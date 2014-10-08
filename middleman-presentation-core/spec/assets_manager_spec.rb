# encoding: utf-8
require 'spec_helper'

RSpec.describe AssetsManager do
  let(:manager) { AssetsManager.new }

  context '#load_from_list' do
    it 'loads assets from list' do
      asset = instance_double('Middleman::Presentation::Asset')

      manager.load_from_list [asset]
      expect(manager).to be_know asset
    end
  end

  context '#each_loadable_asset' do
    it 'iterates over all assets' do
      asset = instance_double('Middleman::Presentation::Asset')
      allow(asset).to receive(:valid?).and_return(true)
      allow(asset).to receive(:loadable?).and_return(true)
      allow(asset).to receive(:source_path).and_return('image1.png')

      manager.load_from_list [asset]

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

      manager.load_from_list [asset1, asset2]

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

      manager.load_from_list [asset1, asset2]

      output = capture :stdout do
        manager.each_importable_javascript { |a| puts a.source_path }
      end

      expect(output).to include 'script.js'
      expect(output).not_to include 'image1.png'
    end
  end

  context '#to_s' do
    it 'returns a string representation of self' do
      asset1 = instance_double('Middleman::Presentation::Asset')
      allow(asset1).to receive(:source_path).and_return('image1.png')
      allow(asset1).to receive(:destination_directory).and_return('output.d')
      allow(asset1).to receive(:loadable?).and_return(true)
      allow(asset1).to receive(:importable?).and_return(true)

      manager.load_from_list [asset1]

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
