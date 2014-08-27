# encoding: utf-8
require 'spec_helper'

RSpec.describe SlideGroup do
  let(:template) { double('Template') }
  let(:slide1) { instance_double('Middleman::Presentation::ExistingSlide') }
  let(:slide2) { instance_double('Middleman::Presentation::ExistingSlide') }

  context '#initialize' do
    it 'requires a name, slides and template' do
      expect do
        SlideGroup.new(name: 'group', slides: [slide1, slide2], template: template)
      end.not_to raise_error
    end
  end

  context '#partial_path' do
    it 'returns path to group file' do
      expect(slide1).to receive(:partial_path).and_return 'path1'
      expect(slide2).to receive(:partial_path).and_return 'path2'

      group = SlideGroup.new(name: 'group', slides: [slide1, slide2], template: template)
      
      expect(group.partial_path).to eq '"path1", "path2"'
    end
  end

  context '#slides' do
    it 'returns slides belonging to group' do
      group = SlideGroup.new(name: 'group', slides: [slide1, slide2], template: template)
      expect(group.slides).to include slide1, slide2
    end
  end

  context '#name' do
    it 'returns name of group' do
      group = SlideGroup.new(name: 'group', slides: [slide1, slide2], template: template)
      expect(group.name).to eq 'group'
    end
  end

  context '#renders' do
    it 'renders slides and uses template' do
      block = proc { |partial_path| }

      expect(slide1).to receive(:render) { |&passed_block| expect(block).to be passed_block }.and_return('01')
      expect(slide2).to receive(:render) { |&passed_block| expect(block).to be passed_block }.and_return('02')
      expect(template).to receive(:result).with(slides: "01\n02")

      group = SlideGroup.new(name: 'group', slides: [slide1, slide2], template: template)
      group.render(&block)
    end
  end
end
