# encoding: utf-8
module Middleman
  module Presentation
    # List of assets
    #
    # The class takes a list of components and generates a list of assets from
    # this. It also includes `Enumerable`
    class AssetList
      include Enumerable

      private

      attr_reader :directory, :creator, :store, :components

      public

      def initialize(components, creator: Asset, store: AssetStore.new)
        @components = components
        @store     = store
        @creator   = creator

        read_in_assets
      end

      # Iternate over each component and execute block
      #
      # @yield
      #   Block which is executed for each component
      def each(&block)
        to_a.each(&block)
      end

      private

      def to_a
        store.assets
      end

      def read_in_assets
        components.each do |c|
          add_assets(
            c.path,
            base_path: c.base_path,
            output_paths: c.output_paths,
            loadable_files: c.loadable_files,
            importable_files: c.importable_files,
            ignorable_files: c.ignorable_files
          )
        end
      end

      def add_assets(search_path, base_path:, output_paths:, loadable_files:, importable_files:, ignorable_files:)
        search_path = File.join(File.expand_path(search_path), '**', '*')

        Dir.glob(search_path).sort.each do |p|
          next unless File.file? p

          # rubocop:disable Style/CaseEquality
          next if !ignorable_files.blank? && Array(ignorable_files).any? { |f| Regexp.new(f) === p }
          # rubocop:enable Style/CaseEquality

          # assets will be find multiple times: vendor/ will find assets in vendor/assets as well
          new_path   = File.join(*Pathname.new(p).relative_path_from(Pathname.new(base_path)).each_filename.to_a)
          next if new_path.to_s.start_with?('assets')

          # rubocop:disable Style/CaseEquality
          output_path = output_paths.find(proc { [] }) { |pattern, _| pattern === p }.last
          # rubocop:enable Style/CaseEquality

          asset = creator.new(source_path: p, relative_source_path: new_path, destination_path: output_path)

          # rubocop:disable Style/CaseEquality
          asset.loadable   = true if loadable_files.any? { |regexp| regexp === p }
          asset.importable = true if importable_files.any? { |regexp| regexp === p }
          # rubocop:enable Style/CaseEquality

          store.add asset
        end

        store
      end
    end
  end
end
