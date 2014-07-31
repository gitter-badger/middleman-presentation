# encoding: utf-8
require 'spec_helper'

RSpec.describe Transformers::TemplateFinder do
  context '#initialize' do 
    it 'requires a base directory' do
      expect {
        Transformers::TemplateFinder.new 'path'
      }.not_to raise_error
    end
  end

  context '#transform' do
    it 'sets template for erb slide' do
      slide = instance_double('Middleman::Presentation::Slide')
      expect(slide).to receive(:has_type?).with(:erb).and_return true
      allow(slide).to receive(:has_type?).and_return false
      expect(slide).to receive(:template=)

      transformer = Transformers::TemplateFinder.new 'path'
      transformer.transform [slide]
    end

    it 'sets template for markdown slide' do
      slide = instance_double('Middleman::Presentation::Slide')
      expect(slide).to receive(:has_type?).with(:md).and_return true
      allow(slide).to receive(:has_type?).and_return false
      expect(slide).to receive(:template=)

      transformer = Transformers::TemplateFinder.new 'path'
      transformer.transform [slide]
    end

    it 'sets template for unknown type' do
      slide = instance_double('Middleman::Presentation::Slide')
      allow(slide).to receive(:has_type?).and_return false
      expect(slide).to receive(:template=)

      transformer = Transformers::TemplateFinder.new 'path'
      transformer.transform [slide]
    end

    it 'sets template for liquid slide' do
      slide = instance_double('Middleman::Presentation::Slide')
      expect(slide).to receive(:has_type?).with(:liquid).and_return true
      allow(slide).to receive(:has_type?).and_return false
      expect(slide).to receive(:template=)

      transformer = Transformers::TemplateFinder.new 'path'
      transformer.transform [slide]
    end
  end
end
