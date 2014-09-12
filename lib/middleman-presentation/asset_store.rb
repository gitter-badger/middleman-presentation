# encoding: utf-8
module Middleman
  module Presentation
    class AssetStore
      private

      attr_reader :store

      public

      def initialize
        @store = []
      end

      def add(asset)
        if existing_asset = @store.find { |a| a.source_path == asset.source_path }
          existing_asset.importable = true if asset.importable
          existing_asset.loadable   = true if asset.loadable
        else
          store << asset
        end
      end

      def assets
        store.uniq
      end

      def find(source_path)
        store.find { |a| a.source_path == source_path }
      end
    end
  end
end
