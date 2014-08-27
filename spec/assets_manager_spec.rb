# encoding: utf-8
require 'spec_helper'

RSpec.describe AssetsManager do
  let(:creator_stub) { Class.new }
  let(:creator) { stub_const('Middleman::Presentation::Asset', creator_stub) }

  context '#load_assets_from' do
    it 'loads multiple assets from directory which has a asset gem layout' do
      touch_file 'app/assets/images/image1.png'
      touch_file 'app/images/image2.png'
      touch_file 'assets/images/image3.png'
      touch_file 'lib/assets/images/image4.png'
      touch_file 'lib/images/image5.png'
      touch_file 'vendor/assets/images/image6.png'
      touch_file 'vendor/assets/css/all.scss'
      touch_file 'vendor/images/image7.png'

      expect(creator).to receive(:new).with(source_path: 'css/all.scss', destination_directory: nil)
      expect(creator).to receive(:new).with(source_path: 'images/image1.png', destination_directory: nil)
      expect(creator).to receive(:new).with(source_path: 'images/image2.png', destination_directory: nil)
      expect(creator).to receive(:new).with(source_path: 'images/image3.png', destination_directory: nil)
      expect(creator).to receive(:new).with(source_path: 'images/image4.png', destination_directory: nil)
      expect(creator).to receive(:new).with(source_path: 'images/image5.png', destination_directory: nil)
      expect(creator).to receive(:new).with(source_path: 'images/image6.png', destination_directory: nil)
      expect(creator).to receive(:new).with(source_path: 'images/image7.png', destination_directory: nil)

      manager = AssetsManager.new(creator: creator)
      manager.load_assets_from File.expand_path(current_dir)
    end

    it 'changes the output_directory' do
      touch_file 'app/assets/images/image1.png'
      expect(creator).to receive(:new).with(source_path: 'images/image1.png', destination_directory: 'asdf.d')

      manager = AssetsManager.new(creator: creator)
      manager.load_assets_from File.expand_path(current_dir), output_directories: { /image/ => 'asdf.d' }
    end

    it 'excludes files' do
      touch_file 'app/assets/images/image1.png'
      touch_file 'app/assets/images/image2.png'

      expect(creator).to receive(:new).with(source_path: 'images/image1.png', destination_directory: nil)

      manager = AssetsManager.new(creator: creator)
      manager.load_assets_from File.expand_path(current_dir), exclude_filter: [/image2/]
    end

    it 'includes files' do
      touch_file 'app/assets/images/image1.png'
      touch_file 'app/assets/images/image2.png'

      expect(creator).to receive(:new).with(source_path: 'images/image1.png', destination_directory: nil)

      manager = AssetsManager.new(creator: creator)
      manager.load_assets_from File.expand_path(current_dir), include_filter: [/image1/]
    end
  end

  context '#each_assets' do
    it 'iterates over all assets' do
      touch_file 'app/assets/images/image1.png'
      touch_file 'app/assets/images/image2.png'

      manager = AssetsManager.new
      manager.load_assets_from File.expand_path(current_dir)

      output = capture :stdout do
        manager.each_asset { |a| puts a.source_path }
      end

      expect(output).to include 'image1.png'
    end
  end

  context '#load_default_components' do
    before :each do
      touch_file 'component1/images/image.png'
      touch_file 'component1/img/image.png'
      touch_file 'component1/css/all.scss'
      touch_file 'component1/stylesheets/all.scss'
      touch_file 'component1/javascripts/all.js'
      touch_file 'component1/js/all.js'
    end

    it 'loads all default components' do
      expect(creator).to receive(:new).with(source_path: 'component1/css/all.scss', destination_directory: nil)
      expect(creator).to receive(:new).with(source_path: 'component1/stylesheets/all.scss', destination_directory: nil)
      expect(creator).to receive(:new).with(source_path: 'component1/images/image.png', destination_directory: nil)
      expect(creator).to receive(:new).with(source_path: 'component1/img/image.png', destination_directory: nil)
      expect(creator).to receive(:new).with(source_path: 'component1/javascripts/all.js', destination_directory: nil)
      expect(creator).to receive(:new).with(source_path: 'component1/js/all.js', destination_directory: nil)

      manager = AssetsManager.new(creator: creator)
      manager.load_default_components File.expand_path(current_dir)
    end
  end

  context '#to_s' do
    it 'returns a string representation of self' do
      manager = AssetsManager.new
      manager.load_assets_from current_dir
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
