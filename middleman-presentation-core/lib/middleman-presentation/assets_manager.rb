# encoding: utf-8
module Middleman
  module Presentation
    # Manager for assets
    #
    # It knows about all assets. This information is used when adding assets to
    # `sprockets`. It gets its information normally from through `plugins` or
    # through reading the bower components directory in filesystem.
    class AssetsManager
      private

      attr_reader :creator, :store

      public

      def initialize(
        creator: Asset, 
        store: AssetStore.new
      )
        @creator = creator
        @store   = store
      end

      # Add asset
      def add(a)
        store.add a 
      end

      #def assets
      #  store.assets
      #end

      # Show assets which should be imported
      def to_s
        data = assets.sort.reduce([]) do |a, e|
          a << { 
            source_path: e.source_path,
            destination_directory: e.destination_directory,
            loadable_files: e.loadable_files,
            importable_files: e.importable_files,
            ignorable_files: e.ignorable_files,
            output_directories: e.output_directories
          }
        end

        List.new(data).to_s(fields: [:source_path, :destination_directory, :importable_files, :loadable_files, :ignorable_files, :output_directories])
      end

      # Iterate over each importable asset
      def each_importable_asset(&block)
        store.find_all { |a| a.valid? && a.importable? }
      end

      # Iterate over each importable asset
      def each_importable_stylesheet(&block)
        each_importable_asset.find_all { |a| a.stylesheet? }.each(&block)
      end

      # Iterate over each importable asset
      def each_importable_javascript(&block)
        each_importable_asset.find_all { |a| a.script? }.each(&block)
      end

      # Load assets from list
      def load_from_list(list)
        store.merge list
      end
    end
  end
end