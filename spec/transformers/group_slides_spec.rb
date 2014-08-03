# encoding: utf-8
require 'spec_helper'

RSpec.describe Transformers::GroupSlides do
  context '#initialize' do
    it 'requires a base directory' do
      template = double('Template')
      allow(template).to receive(:result)

      expect {
        Transformers::GroupSlides.new(template: template)
      }.not_to raise_error
    end
  end

  context '#transforms' do
    it 'groups slides with same group' do
      slide1 = instance_double('Middleman::Presentation::Slide')
      allow(slide1).to receive(:group).and_return 'group'
      allow(slide1).to receive(:has_group?).and_return true
      allow(slide1).to receive(:partial_path).and_return 'slides/01.html.erb'
      allow(slide1).to receive(:render).and_return '01'

      slide2 = instance_double('Middleman::Presentation::Slide')
      allow(slide2).to receive(:group).and_return 'group'
      allow(slide2).to receive(:has_group?).and_return true
      allow(slide2).to receive(:partial_path).and_return 'slides/02.html.erb'
      allow(slide2).to receive(:render).and_return '02'

      slide3 = instance_double('Middleman::Presentation::Slide')
      allow(slide3).to receive(:group).and_return nil
      allow(slide3).to receive(:has_group?).and_return false
      allow(slide3).to receive(:partial_path).and_return 'slides/03.html.erb'
      allow(slide3).to receive(:render).and_return '03'

      transformer = Transformers::GroupSlides.new(template: Erubis::Eruby.new('<%= slides %>'))
      result = transformer.transform [slide1, slide2, slide3]

      expect(result).not_to include slide1
      expect(result).not_to include slide2
      expect(result).to include slide3

      group = result.first
      expect(group.render { |s| s }).to include "01\n02"
    end
  end
end
