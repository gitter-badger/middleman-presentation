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

      # Add asset
      def add(asset)
        binding.pry
        if existing_asset = @store.find { |a| a.source_path == asset.source_path }
          existing_asset.merge! asset
        else
          store << asset
        end
      end

      # Merge list
      #
      # @param [#each] list_or_store
      #   The list to merge
      def merge(list_or_store)
        list_or_store.each { |a| add a }
      end

      # All uniq assets
      def assets
        store.uniq
      end

      # Iterate over assets 
      def each(&block)
        assets.each(&block)
      end

      # Find all assets matching criteria
      #
      # @param [String] source_path (optional)
      #   Source path to be used
      #
      # @yield
      #   Search criteria
      def find_all(source_path: nil, &block)
        if block_given?
          store.find_all(&block)
        else
          store.find_all { |a| a.source_path == source_path }
        end
      end

      # Find asset matching criteria
      #
      # @see #find_all
      def find(**args, &block)
        find_all(**args, &block).first
      end
    end
  end
end
