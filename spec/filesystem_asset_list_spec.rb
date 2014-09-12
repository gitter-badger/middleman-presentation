# encoding: utf-8
require 'spec_helper'

RSpec.describe FilesystemAssetList do
  let(:creator_stub) { Class.new }
  let(:creator) { stub_const('Middleman::Presentation::Asset', creator_stub) }
  let(:asset) { instance_double('Middleman::Presentation::Asset') }

  context '#initialize' do
    it 'reads from directory' do
      touch_file 'images/image1.png'
      touch_file 'images/image2.png'

      expect(creator).to receive(:new).with(source_path: 'images/image1.png', destination_directory: nil)
      expect(creator).to receive(:new).with(source_path: 'images/image2.png', destination_directory: nil)

      FilesystemAssetList.new(
        directory: absolute_path('.'),
        creator: creator
      ).each {}
    end

    it 'sets output directory' do
      touch_file 'images/image1.png'

      expect(creator).to receive(:new).with(source_path: 'images/image1.png', destination_directory: 'test')

      FilesystemAssetList.new(
        directory: absolute_path('.'),
        creator: creator,
        output_directories: {
          %r{images/} => 'test'
        }
      ).each {}
    end

    it 'marks assets as importable' do
      touch_file 'images/image1.png'

      expect(creator).to receive(:new).with(source_path: 'images/image1.png', destination_directory: nil).and_return(asset)
      expect(asset).to receive(:importable=).with(true)

      FilesystemAssetList.new(
        directory: absolute_path('.'),
        creator: creator,
        importable_files: [ 
          %r{images/}
        ]
      ).each {}
    end

    it 'marks assets as loadable' do
      touch_file 'images/image1.png'

      expect(creator).to receive(:new).with(source_path: 'images/image1.png', destination_directory: nil).and_return(asset)
      expect(asset).to receive(:loadable=).with(true)

      FilesystemAssetList.new(
        directory: absolute_path('.'),
        creator: creator,
        loadable_files: [ 
          %r{images/}
        ]
      ).each {}
    end

    it 'ignores files' do
      touch_file 'images/image1.png'
      touch_file 'images.old/image1.png'

      expect(creator).to receive(:new).with(source_path: 'images/image1.png', destination_directory: nil)

      FilesystemAssetList.new(
        directory: absolute_path('.'),
        creator: creator,
        ignorable_files: [ 
          %r{images.old/}
        ]
      ).each {}
    end
  end

  context '#each' do
    it 'iterates of assets' do
      touch_file 'images/image1.png'

      expect(creator).to receive(:new).with(source_path: 'images/image1.png', destination_directory: nil).and_return(asset)

      list = FilesystemAssetList.new(
        directory: absolute_path('.'),
        creator: creator
      )
      
      result = []
      list.each { |a| result << a }

      expect(result).to include asset
    end
  end
end
