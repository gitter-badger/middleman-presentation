# encoding: utf-8
require 'spec_helper'

RSpec.describe SlideName do
  context '#to_s' do
    let(:old_slide) { instance_double('Middleman::Presentation::ExistingSlide') }

    it 'switches type from erb to md if no basename/type is given' do
      expect(old_slide).to receive(:base_name).and_return('01')
      expect(old_slide).to receive(:ext_name).and_return('.html.erb')

      name = SlideName.new(old_slide, base_name: nil, type: nil)
      expect(name.to_s).to eq '01.md'
    end

    it 'switches type from erb to md if no basename/type is given' do
      expect(old_slide).to receive(:base_name).and_return('01')
      expect(old_slide).to receive(:ext_name).and_return('.html.md')

      name = SlideName.new(old_slide, base_name: nil, type: nil)
      expect(name.to_s).to eq '01.erb'
    end

    it 'switches type from other types than erb/md to md only if no basename/type is given' do
      expect(old_slide).to receive(:base_name).and_return('01')
      expect(old_slide).to receive(:ext_name).and_return('.html.liquid')

      name = SlideName.new(old_slide, base_name: nil, type: nil)
      expect(name.to_s).to eq '01.md'
    end

    it 'switches to given type and uses base name from old slide' do
      expect(old_slide).to receive(:base_name).and_return('01')

      name = SlideName.new(old_slide, base_name: nil, type: 'erb')
      expect(name.to_s).to eq '01.erb'
    end

    it 'switches to given type (with dot) and uses base name from old slide' do
      expect(old_slide).to receive(:base_name).and_return('01')

      name = SlideName.new(old_slide, base_name: nil, type: '.erb')
      expect(name.to_s).to eq '01.erb'
    end

    it 'switches to given basename and uses type from old slide' do
      expect(old_slide).to receive(:ext_name).and_return('.html.erb')

      name = SlideName.new(old_slide, base_name: '02', type: nil)
      expect(name.to_s).to eq '02.erb'
    end
  end
end
