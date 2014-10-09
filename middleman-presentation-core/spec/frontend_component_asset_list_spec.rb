# encoding: utf-8
require 'spec_helper'

RSpec.describe FrontendComponentAssetList do
  let(:creator_stub) { Class.new }
  let(:creator) { stub_const('Middleman::Presentation::Asset', creator_stub) }
  let(:asset) { instance_double('Middleman::Presentation::Asset') }
  let(:component) { instance_double('Middleman::Presentation::FrontendComponent') }

  context '#initialize' do
    it 'information reads from component' do
      touch_file 'component1/images/image1.png'

      expect(component).to receive(:output_directories).and_return([])
      expect(component).to receive(:loadable_files).and_return([])
      expect(component).to receive(:importable_files).and_return([])
      expect(component).to receive(:ignorable_files).and_return([])

      expect(creator).to receive(:new).with(source_path: absolute_path('component1/images/image1.png'), relative_source_path: 'component1/images/image1.png', destination_directory: nil)

      FrontendComponentAssetList.new(
        components: component,
        directory: absolute_path('.'),
        creator: creator
      ).each {}
    end
  end
end

  #  it 'sets output directory' do
  #    touch_file 'images/image1.png'

  #    expect(creator).to receive(:new).with(source_path: absolute_path('images/image1.png'), relative_source_path: 'images/image1.png', destination_directory: 'test')

  #    FilesystemAssetList.new(
  #      directory: absolute_path('.'),
  #      creator: creator,
  #      output_directories: {
  #        %r{images/} => 'test'
  #      }
  #    ).each {}
  #  end

  #  it 'marks assets as importable' do
  #    touch_file 'images/image1.png'

  #    expect(creator).to receive(:new).with(source_path: absolute_path('images/image1.png'), relative_source_path: 'images/image1.png', destination_directory: nil).and_return(asset)
  #    expect(asset).to receive(:importable=).with(true)

  #    FilesystemAssetList.new(
  #      directory: absolute_path('.'),
  #      creator: creator,
  #      importable_files: [ 
  #        %r{images/}
  #      ]
  #    ).each {}
  #  end

  #  it 'marks assets as loadable' do
  #    touch_file 'images/image1.png'

  #    expect(creator).to receive(:new).with(source_path: absolute_path('images/image1.png'), relative_source_path: 'images/image1.png', destination_directory: nil).and_return(asset)
  #    expect(asset).to receive(:loadable=).with(true)

  #    FilesystemAssetList.new(
  #      directory: absolute_path('.'),
  #      creator: creator,
  #      loadable_files: [ 
  #        %r{images/}
  #      ]
  #    ).each {}
  #  end

  #  it 'ignores files' do
  #    touch_file 'images/image1.png'
  #    touch_file 'images.old/image1.png'

  #    expect(creator).to receive(:new).with(source_path: absolute_path('images/image1.png'), relative_source_path: 'images/image1.png', destination_directory: nil)

  #    FilesystemAssetList.new(
  #      directory: absolute_path('.'),
  #      creator: creator,
  #      ignorable_files: [ 
  #        %r{images.old/}
  #      ]
  #    ).each {}
  #  end
  #end

  #context '#each' do
  #  it 'iterates of assets' do
  #    touch_file 'images/image1.png'

  #    expect(creator).to receive(:new).with(source_path: absolute_path('images/image1.png'), relative_source_path: 'images/image1.png', destination_directory: nil).and_return(asset)

  #    list = FilesystemAssetList.new(
  #      directory: absolute_path('.'),
  #      creator: creator
  #    )
  #    
  #    result = []
  #    list.each { |a| result << a }

  #    expect(result).to include asset
  #  end
  #end
#end
