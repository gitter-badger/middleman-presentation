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
      asset2 = instance_double('Middleman::Presentation::Asset')
      allow(asset2).to receive(:source_path).and_return('source/path')

      asset1 = instance_double('Middleman::Presentation::Asset')
      allow(asset1).to receive(:source_path).and_return('source/path')
      expect(asset1).to receive(:merge!).with(asset2)

      store = AssetStore.new
      store.add asset1
      store.add asset2
    end
  end

  context '#find' do
    it 'finds existing assets' do
      asset = OpenStruct.new(source_path: 'asset/path', loadable: false)

      store = AssetStore.new
      store.add asset

      asset = store.find source_path: asset.source_path

      expect(asset).to be asset
    end

    it 'uses a block as well' do
      asset = OpenStruct.new(source_path: 'asset/path', loadable: false)

      store = AssetStore.new
      store.add asset

      asset = store.find { |a| a.source_path == asset.source_path }

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
