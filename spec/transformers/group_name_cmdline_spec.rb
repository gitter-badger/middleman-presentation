# encoding: utf-8
require 'spec_helper'

RSpec.describe Transformers::GroupNameCmdline do
  context '#transform' do
    it 'sets group to nil if not exists' do
      slide1 = instance_double('Middleman::Presentation::Slide')
      allow(slide1).to receive(:name).and_return '01'
      allow(slide1).to receive(:name=).with '01'
      allow(slide1).to receive(:group=).with nil

      transformer = Transformers::GroupNameCmdline.new
      transformer.transform [slide1]
    end

    it 'sets group to value if exists' do
      slide1 = instance_double('Middleman::Presentation::Slide')
      allow(slide1).to receive(:name).and_return 'group:01'
      allow(slide1).to receive(:name=).with '01'
      allow(slide1).to receive(:group=).with 'group'

      transformer = Transformers::GroupNameCmdline.new
      transformer.transform [slide1]
    end

    it 'handles subgroups as well' do
      slide1 = instance_double('Middleman::Presentation::Slide')
      allow(slide1).to receive(:name).and_return 'group:subgroup:01'
      allow(slide1).to receive(:name=).with '01'
      allow(slide1).to receive(:group=).with 'group:subgroup'

      transformer = Transformers::GroupNameCmdline.new
      transformer.transform [slide1]
    end
  end
end
