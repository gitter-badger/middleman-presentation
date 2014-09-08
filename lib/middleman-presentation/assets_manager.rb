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

      attr_reader :assets, :creator, :loadable, :importable

      public

      attr_writer :importable, :loadable

      def initialize(creator: Asset)
        @creator             = creator
        @assets              = Set.new
      end

      # Add asset
      def add(a)
        assets << a
      end

      # Show assets which should be imported
      def to_s
        data = assets.sort.reduce([]) do |a, e|
          a << { 
            source_path: e.source_path,
            destination_directory: e.destination_directory,
            loadable: loadable,
            importable: importable,
          }
        end

        List.new(data).to_s(fields: [:source_path, :destination_directory, :loadable, :importable])
      end

      # Iterate over each importable asset
      def each_importable_asset(&block)
        assets.dup.each(&block)
      end

      # Iterate over each importable asset
      def each_importable_stylesheet(&block)
        assets.find_all { |a| a.valid? && a.importable? && a.stylesheet? }.each(&block)
      end

      # Iterate over each importable asset
      def each_importable_javascript(&block)
        assets.find_all { |a| a.valid? && a.importable? && a.script? }.each(&block)
      end

      # Load assets from list
      def load_from_list(list)
        assets.concat list.to_a
      end
    end
  end
end
