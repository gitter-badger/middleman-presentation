# encoding: utf-8
module Middleman
  module Presentation
    class AssetList
      include Enumerable

      private

      attr_reader :directory, :creator, :store_creator

      public

      def initialize(directory:, creator: Asset, store: AssetStore.new)
        @directory = directory
        @store     = store
        @creator   = creator

        read_in_assets
      end

      def each(&block)
        to_a.each(&block)
      end

      private

      def to_a
        store.assets
      end

      def read_in_assets
        fail NoMethodError, :read_in_assets
      end

      def add_assets(base_path, output_directories:, loadable_files:, importable_files:, ignorable_files:)
        base_path   = File.expand_path(base_path)
        search_path = File.join(base_path, '**', '*')

        Dir.glob(search_path).sort.each do |p|
          next unless File.file? p

          # rubocop:disable Style/CaseEquality
          next if !ignorable_files.blank? && Array(ignorable_files).any? { |f| Regexp.new(f) === p }
          # rubocop:enable Style/CaseEquality

          # assets will be find multiple times: vendor/ will find assets in vendor/assets as well
          new_path   = File.join(*Pathname.new(p).relative_path_from(Pathname.new(base_path)).each_filename.to_a)
          next if new_path.to_s.start_with?('assets')

          # rubocop:disable Style/CaseEquality
          output_dir = output_directories.find(proc { [] }) { |pattern, _| pattern === p }.last
          # rubocop:enable Style/CaseEquality

          asset = creator.new(source_path: new_path, destination_directory: output_dir)

          asset.loadable   = true if loadable_files.any? { |regexp| regexp === p }
          asset.importable = true if importable_files.any? { |regexp| regexp === p }

          store.add asset
        end

        store
      end
    end
  end
end
