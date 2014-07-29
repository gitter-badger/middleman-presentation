# encoding: utf-8
require 'spec_helper'

RSpec.describe SlideGroup, :focus do
  context '#initialize' do 
    it 'requires a name, slides and template' do
      template = double('Template')
      allow(template).to receive(:result).and_return "01\n02"

      slide1 = instance_double('Middleman::Presentation::Slide')
      allow(slide1).to receive(:content).and_return '01'

      slide2 = instance_double('Middleman::Presentation::Slide')
      allow(slide2).to receive(:content).and_return '02'

      expect {
        SlideGroup.new(name: 'group', slides: [ slide1, slide2 ], template: template)
      }.not_to raise_error
    end
  end

  context '#partial_path' do
    it 'returns path to group file' do
      template = double('Template')
      allow(template).to receive(:result).and_return "01\n02"

      slide1 = instance_double('Middleman::Presentation::Slide')
      allow(slide1).to receive(:content).and_return '01'

      slide2 = instance_double('Middleman::Presentation::Slide')
      allow(slide2).to receive(:content).and_return '02'

      group = SlideGroup.new(name: 'group', slides: [ slide1, slide2 ], template: template)
      expect(group).to respond_to :partial_path
    end
  end

  context '#slides' do
    it 'returns slides belonging to group' do
      template = double('Template')
      allow(template).to receive(:result).and_return "01\n02"

      slide1 = instance_double('Middleman::Presentation::Slide')
      allow(slide1).to receive(:content).and_return '01'

      slide2 = instance_double('Middleman::Presentation::Slide')
      allow(slide2).to receive(:content).and_return '02'

      group = SlideGroup.new(name: 'group', slides: [ slide1, slide2 ], template: template)
      expect(group.slides).to include slide1, slide2
    end
  end

  context '#name' do
    it 'returns name of group' do
      template = double('Template')
      allow(template).to receive(:result).and_return "01\n02"

      slide1 = instance_double('Middleman::Presentation::Slide')
      allow(slide1).to receive(:content).and_return '01'

      slide2 = instance_double('Middleman::Presentation::Slide')
      allow(slide2).to receive(:content).and_return '02'

      group = SlideGroup.new(name: 'group', slides: [ slide1, slide2 ], template: template)
      expect(group.name).to eq 'group'
    end
  end
end
