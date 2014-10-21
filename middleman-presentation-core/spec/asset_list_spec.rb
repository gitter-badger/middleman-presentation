# encoding: utf-8
require 'spec_helper'

RSpec.describe AssetList do
  let(:creator_stub) { Class.new }
  let(:creator) { stub_const('Middleman::Presentation::Asset', creator_stub) }
  let(:asset) { instance_double('Middleman::Presentation::Asset') }

  context '#initialize' do
    it 'creates asset instances' do
      touch_file 'stylesheets/blub.scss'

      expect(creator).to receive(:new).with(source_path: absolute_path('stylesheets/blub.scss'), relative_source_path: 'blub.scss', destination_directory: nil).and_return(asset)

      component1 = instance_double('Middleman::Presentation::Component')
      allow(component1).to receive(:path).and_return(absolute_path('stylesheets'))
      allow(component1).to receive(:output_directories).and_return([])
      allow(component1).to receive(:loadable_files).and_return([])
      allow(component1).to receive(:ignorable_files).and_return([])
      allow(component1).to receive(:importable_files).and_return([])

      components = []
      components << component1

      result = []
      AssetList.new(components).each { |a| result << a }

      expect(result).to include asset
    end
  end

  #context '#each' do
  #  it 'iterates of assets' do
  #    expect(creator).to receive(:new).with(source_path: absolute_path('images/image1.png'), relative_source_path: 'images/image1.png', destination_directory: nil).and_return(asset)

  #    component1 = instance_double('Middleman::Presentation::Component')
  #    allow(component1).to receive(:path).and_return(absolute_path('images/image1.png'))
  #    allow(component1).to receive(:output_directories).and_return(absolute_path('images/image1.png'))

  #    components = []
  #    components << component1

  #    result = []
  #    result = AssetList.new(components).each { |a| result << a }

  #    expect(result).to include asset
  #  end
  #end
end
