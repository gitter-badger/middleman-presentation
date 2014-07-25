# encoding: utf-8
require 'spec_helper'

RSpec.describe SlideList do

  context '#initialize' do
    it 'requires a list of patterns' do
      slide = double('Middleman::Presentation::NewSlide')
      allow(slide).to receive(:name).and_return '01'

      slide_builder = double('Middleman::Presentation::NewSlide')
      allow(slide_builder).to receive(:new).and_return slide

      expect {
        SlideList.new('01', slide_builder: slide_builder)
      }.not_to raise_error
    end

    it 'accepts a block' do
      slide = double('Middleman::Presentation::NewSlide')
      allow(slide).to receive(:name).and_return '01'

      slide_builder = double('Middleman::Presentation::NewSlide')
      allow(slide_builder).to receive(:new).and_return slide

      expect {
        SlideList.new('01', slide_builder: slide_builder) do |l|
        end
      }.not_to raise_error
    end
  end

  context '#all' do
    it 'holds all slides: existing and not existing' do
      create_file '01'
      create_file '02'

      slide_builder = double('Middleman::Presentation::NewSlide')

      %w{01 02 03}.each do |name|
        expect(slide_builder).to receive(:new).with(name: name).and_return(OpenStruct.new(name: name))
      end

      list = SlideList.new(%w{ 01 02 03 }, slide_builder: slide_builder)
      expect(list.all.size).to eq 3
    end

    it 'fails on duplicate slide names' do
      expect {
        SlideList.new(%w{01.erb 01.md})
      }.to raise_error ArgumentError
    end
  end

  context '#transform_with' do
    it 'takes a transformer an to modify each entry' do
      slide = double('Middleman::Presentation::NewSlide')
      allow(slide).to receive(:name).and_return '01'

      slide_builder = double('Middleman::Presentation::NewSlide')
      allow(slide_builder).to receive(:new).and_return slide

      transformer = double('Transformer')
      expect(transformer).to receive(:transform)

      SlideList.new(%w{01}, slide_builder: slide_builder).transform_with transformer
    end
  end

  context '#each_new' do
    it 'iterates over all non existing slides because they are assumed to be new' do
      slide = double('Slide')
      expect(slide).to receive(:exist?).and_return false

      slide_builder = double('Middleman::Presentation::NewSlide')
      allow(slide_builder).to receive(:new).and_return slide

      SlideList.new(%w{01}, slide_builder: slide_builder).each_new { }
    end
  end

  context '#existing_slides' do
    it 'returns all existing slides' do
      slide = double('Slide')
      expect(slide).to receive(:exist?).and_return true

      slide_builder = double('Middleman::Presentation::NewSlide')
      allow(slide_builder).to receive(:new).and_return slide

      existing_slides = SlideList.new(%w{01}, slide_builder: slide_builder).existing_slides
      expect(existing_slides).to include slide
    end
  end
end
