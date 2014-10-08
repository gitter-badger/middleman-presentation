# encoding: utf-8
require 'spec_helper'

RSpec.describe AssetsManager do
  let(:manager) { AssetsManager.new }

  context '#load_from_list' do
    it 'loads assets from list' do
      asset = instance_double('Middleman::Presentation::Asset')
      allow(asset).to receive(:loadable).and_return(true)
      allow(asset).to receive(:source_path).and_return('image1.png')

      manager.load_from_list [asset]
      expect(manager.assets).to include asset
    end
  end

  context '#each_loadable_asset' do
    it 'iterates over all assets' do
      asset = instance_double('Middleman::Presentation::Asset')
      allow(asset).to receive(:loadable).and_return(true)
      allow(asset).to receive(:source_path).and_return('image1.png')

      allow(list).to receive(:each).and_return([asset].each)

      manager.load_from_list [asset]

      output = capture :stdout do
        manager.each_loadable_asset { |a| puts a.source_path }
      end

      expect(output).to include 'image1.png'
    end
  end

  context '#each_importable_stylesheet' do
    it 'iterates over all assets' do
      touch_file 'app/assets/images/image1.png'
      touch_file 'app/assets/images/image2.png'

      manager.load_from_list list

      output = capture :stdout do
        manager.each_asset { |a| puts a.source_path }
      end

      expect(output).to include 'image1.png'
    end
  end

  context '#each_importable_script' do
    it 'iterates over all assets' do
      touch_file 'app/assets/images/image1.png'
      touch_file 'app/assets/images/image2.png'

      manager.load_from_list list

      output = capture :stdout do
        manager.each_asset { |a| puts a.source_path }
      end

      expect(output).to include 'image1.png'
    end
  end

  context '#to_s' do
    it 'returns a string representation of self' do
      #manager.load_from_list list
      manager.add('images/image.png', 'output.d')

      expect(manager.to_s).to eq <<-EOS.strip_heredoc.chomp
        +------------------+-----------------------+
        | Source path      | Destination directory |
        +------------------+-----------------------+
        | images/image.png | output.d              |
        +------------------+-----------------------+
        1 row in set
      EOS
    end
  end
end
