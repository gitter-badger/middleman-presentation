# encoding: utf-8
require 'spec_helper'

RSpec.describe Transformers::GroupNameFilesystem do
  context '#transform' do
    it 'sets group to nil if not exists' do
      slide1 = instance_double('Middleman::Presentation::Slide')
      allow(slide1).to receive(:name).and_return File.join(working_directory, '01.html.erb')
      allow(slide1).to receive(:name=).with '01.html.erb'
      allow(slide1).to receive(:group=).with nil

      transformer = Transformers::GroupNameFilesystem.new working_directory
      transformer.transform [slide1]
    end

    it 'sets group to value if exists' do
      slide1 = instance_double('Middleman::Presentation::Slide')
      allow(slide1).to receive(:name).and_return File.join(working_directory, 'group', '01.html.erb')
      allow(slide1).to receive(:name=).with '01.html.erb'
      allow(slide1).to receive(:group=).with 'group'

      transformer = Transformers::GroupNameFilesystem.new working_directory
      transformer.transform [slide1]
    end

    it 'handles nested groups as well' do
      slide1 = instance_double('Middleman::Presentation::Slide')
      allow(slide1).to receive(:name).and_return File.join(working_directory, 'group', 'subgroup', '01.html.erb')
      allow(slide1).to receive(:name=).with '01.html.erb'
      allow(slide1).to receive(:group=).with 'group:subgroup'

      transformer = Transformers::GroupNameFilesystem.new working_directory
      transformer.transform [slide1]
    end

  end
end
