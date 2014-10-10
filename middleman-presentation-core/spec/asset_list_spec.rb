# encoding: utf-8
require 'spec_helper'

RSpec.describe FilesystemAssetList do
  let(:creator_stub) { Class.new }
  let(:creator) { stub_const('Middleman::Presentation::Asset', creator_stub) }
  let(:asset) { instance_double('Middleman::Presentation::Asset') }

  let(:asset_list_klass) do
    Class.new(AssetList) do
      def read_in_assets
        add_assets(
          directory,
          output_directories: [],
          loadable_files: [],
          importable_files: [],
          ignorable_files: [],
        )
      end
    end
  end

  context '#each' do
    it 'iterates of assets' do
      touch_file 'images/image1.png'

      expect(creator).to receive(:new).with(source_path: absolute_path('images/image1.png'), relative_source_path: 'images/image1.png', destination_directory: nil).and_return(asset)

      list = asset_list_klass.new(
        directory: absolute_path('.'),
        creator: creator
      )
      
      result = []
      list.each { |a| result << a }

      expect(result).to include asset
    end
  end
end
