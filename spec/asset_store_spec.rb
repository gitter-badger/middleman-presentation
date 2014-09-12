# encoding: utf-8
require 'spec_helper'

RSpec.describe AssetStore do
  context '#add' do
    it 'adds asset to store' do
      asset = instance_double('Middleman::Presentation::Asset')

      store = AssetStore.new
      expect { store.add asset }.not_to raise_error
    end

    it 'merges existing assets' do
      asset1 = OpenStruct.new(source_path: 'asset/path')
      asset2 = OpenStruct.new(source_path: 'asset/path')

      store = AssetStore.new
      store.add asset1
      store.add asset2

      expect(store.assets.count).to eq 1
    end

    it 'keeps information about importable' do
      asset1 = OpenStruct.new(source_path: 'asset/path', importable: false)
      asset2 = OpenStruct.new(source_path: 'asset/path', importable: true)

      store = AssetStore.new
      store.add asset1
      store.add asset2

      asset = store.find asset1.source_path

      expect(asset.importable).to eq true
    end

    it 'keeps information about loadable' do
      asset1 = OpenStruct.new(source_path: 'asset/path', loadable: false)
      asset2 = OpenStruct.new(source_path: 'asset/path', loadable: true)

      store = AssetStore.new
      store.add asset1
      store.add asset2

      asset = store.find asset1.source_path

      expect(asset.loadable).to eq true
    end

    it 'keeps information about destination directory' do
      asset1 = OpenStruct.new(source_path: 'asset/path', destination_directory: 'dir')
      asset2 = OpenStruct.new(source_path: 'asset/path', destination_directory: 'dir2')

      store = AssetStore.new
      store.add asset1
      store.add asset2

      asset = store.find asset1.source_path

      expect(asset.destination_directory).to eq 'dir'
    end

    it 'adds information about destination directory if does not exist' do
      asset1 = OpenStruct.new(source_path: 'asset/path', destination_directory: nil)
      asset2 = OpenStruct.new(source_path: 'asset/path', destination_directory: 'dir2')

      store = AssetStore.new
      store.add asset1
      store.add asset2

      asset = store.find asset1.source_path

      expect(asset.destination_directory).to eq 'dir2'
    end
  end

  context '#find' do
    it 'finds existing assets' do
      asset = OpenStruct.new(source_path: 'asset/path', loadable: false)

      store = AssetStore.new
      store.add asset

      asset = store.find asset.source_path

      expect(asset).to be asset
    end
  end

  context '#assets' do
    it 'returns assets stored in asset store' do
      asset = instance_double('Middleman::Presentation::Asset')

      store = AssetStore.new
      store.add asset

      expect(store.assets).to include asset
    end
  end
end
