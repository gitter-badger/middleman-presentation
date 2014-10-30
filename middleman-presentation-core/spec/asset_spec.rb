# encoding: utf-8
require 'spec_helper'

RSpec.describe Asset do
  context '#merge!' do
    it 'keeps information about importable' do
      asset1 = Asset.new(source_path: absolute_path('asset/path'), importable: false, relative_source_path: 'asset/path', destination_path: nil)
      asset2 = Asset.new(source_path: absolute_path('asset/path'), importable: true, relative_source_path: 'asset/path', destination_path: nil)
      asset1.merge! asset2

      expect(asset1).to be_importable
    end

    it 'keeps information about loadable' do
      asset1 = Asset.new(source_path: absolute_path('asset/path'), loadable: false, relative_source_path: 'asset/path', destination_path: nil)
      asset2 = Asset.new(source_path: absolute_path('asset/path'), loadable: true, relative_source_path: 'asset/path', destination_path: nil)
      asset1.merge! asset2

      expect(asset1).to be_loadable
    end

    it 'keeps information about destination path' do
      asset1 = Asset.new(source_path: absolute_path('asset/path'), relative_source_path: 'asset/path', destination_path: 'dir')
      asset2 = Asset.new(source_path: absolute_path('asset/path'), relative_source_path: 'asset/path', destination_path: 'dir2')

      asset1.merge! asset2

      expect(asset1.destination_path).to eq Pathname.new('dir')
    end

    it 'adds information about destination path if does not exist' do
      asset1 = Asset.new(source_path: absolute_path('asset/path'), relative_source_path: 'asset/path', destination_path: nil)
      asset2 = Asset.new(source_path: absolute_path('asset/path'), relative_source_path: 'asset/path', destination_path: 'dir2')

      asset1.merge! asset2

      expect(asset1.destination_path).to eq Pathname.new('dir2')
    end

    it 'has an import path' do
      asset = Asset.new(source_path: absolute_path('asset/path/image.png'), relative_source_path: 'asset/path/image.png', destination_path: nil)
      expect(asset.import_path).to eq Pathname.new('asset/path/image')
    end
  end
end
