# encoding: utf-8
require 'spec_helper'

RSpec.describe AssetsManager do
  let(:manager) { AssetsManager.new }
  let(:asset) { instance_double('Middleman::Presentation::Asset') }
  let(:list) { instance_double('Middleman::Presentation::AssetList') }

  context '#load_from_list' do
    it 'loads assets from list' do
      allow(list).to receive(:each) { |&block| [asset].each(&block) }

      manager.load_from_list list
      expect(manager).to be_know asset
    end
  end

  context '#each_loadable_asset' do
    it 'iterates over all assets' do
      allow(asset).to receive(:valid?).and_return(true)
      allow(asset).to receive(:loadable?).and_return(true)
      allow(asset).to receive(:source_path).and_return('image1.png')

      allow(list).to receive(:each) { |&block| [asset].each(&block) }

      manager.load_from_list list

      output = capture :stdout do
        manager.each_loadable_asset { |a| puts a.source_path }
      end

      expect(output).to include 'image1.png'
    end
  end

  context '#each_importable_stylesheet' do
    it 'iterates over all assets' do
      asset1 = instance_double('Middleman::Presentation::Asset')
      allow(asset1).to receive(:valid?).and_return(true)
      allow(asset1).to receive(:importable?).and_return(true)
      allow(asset1).to receive(:stylesheet?).and_return(false)
      allow(asset1).to receive(:source_path).and_return('image1.png')

      asset2 = instance_double('Middleman::Presentation::Asset')
      allow(asset2).to receive(:valid?).and_return(true)
      allow(asset2).to receive(:importable?).and_return(true)
      allow(asset2).to receive(:stylesheet?).and_return(true)
      allow(asset2).to receive(:source_path).and_return('stylesheet.css')

      allow(list).to receive(:each) { |&block| [asset1, asset2].each(&block) }

      manager.load_from_list list

      output = capture :stdout do
        manager.each_importable_stylesheet { |a| puts a.source_path }
      end

      expect(output).to include 'stylesheet.css'
      expect(output).not_to include 'image1.png'
    end
  end

  context '#each_importable_javascript' do
    it 'iterates over all assets' do
      asset1 = instance_double('Middleman::Presentation::Asset')
      allow(asset1).to receive(:valid?).and_return(true)
      allow(asset1).to receive(:importable?).and_return(true)
      allow(asset1).to receive(:script?).and_return(false)
      allow(asset1).to receive(:source_path).and_return('image1.png')

      asset2 = instance_double('Middleman::Presentation::Asset')
      allow(asset2).to receive(:valid?).and_return(true)
      allow(asset2).to receive(:importable?).and_return(true)
      allow(asset2).to receive(:script?).and_return(true)
      allow(asset2).to receive(:source_path).and_return('script.js')

      allow(list).to receive(:each) { |&block| [asset1, asset2].each(&block) }

      manager.load_from_list list

      output = capture :stdout do
        manager.each_importable_javascript { |a| puts a.source_path }
      end

      expect(output).to include 'script.js'
      expect(output).not_to include 'image1.png'
    end
  end

  context '#to_s' do
    it 'returns a string representation of self' do
      allow(asset).to receive(:source_path).and_return('image1.png')
      allow(asset).to receive(:destination_directory).and_return('output.d')
      allow(asset).to receive(:loadable?).and_return(true)
      allow(asset).to receive(:importable?).and_return(true)

      allow(list).to receive(:each) { |&block| [asset].each(&block) }

      manager.load_from_list list

      expect(manager.to_s).to eq <<-EOS.strip_heredoc.chomp
        +-------------+-----------------------+----------+------------+
        | Source path | Destination directory | Loadable | Importable |
        +-------------+-----------------------+----------+------------+
        | image1.png  | output.d              | true     | true       |
        +-------------+-----------------------+----------+------------+
        1 row in set
      EOS
    end
  end
end
