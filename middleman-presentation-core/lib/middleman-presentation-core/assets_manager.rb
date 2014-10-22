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

      attr_reader :store

      public

      def initialize(
        store: AssetStore.new
      )
        @store   = store
      end

      # Add asset
      def add(asset)
        store.add asset
      end

      # Return assets
      def know?(asset)
        store.include? asset
      end

      # Show assets which should be imported
      def to_s
        data = store.assets.sort.reduce([]) do |a, e|
          a << {
            source_path: e.source_path,
            destination_directory: e.destination_directory,
            loadable: e.loadable?,
            importable: e.importable?
          }
        end

        List.new(data).to_s(fields: [:source_path, :destination_directory, :loadable, :importable])
      end

      # Iterate over each loadable asset
      def each_loadable_asset(&block)
        store.select { |a| a.valid? && a.loadable? }.each(&block)
      end

      # Iterate over each importable asset
      def each_importable_stylesheet(&block)
        each_importable_asset.reverse.select(&:stylesheet?).each(&block)
      end

      # Iterate over each importable asset
      def each_importable_javascript(&block)
        each_importable_asset.select(&:script?).each(&block)
      end

      # Load assets from list
      def load_from_list(*lists)
        lists.flatten.each { |l| store.merge l }
      end

      private

      def each_importable_asset(&_block)
        store.select { |a| a.valid? && a.importable? }
      end
    end
  end
end
