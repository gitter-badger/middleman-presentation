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

      attr_reader :assets, :creator, :loadable_files_db, :importable_files_db

      public

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

      # Load assets from path
      #
      # Make sure the path has the same layout like asset gems. Supported paths:
      #
      # * assets
      # * app
      # * app/assets
      # * vendor
      # * vendor/assets
      # * lib
      # * lib/assets
      #
      # This method will remove everything till the "type"-directory, e.g. image, stylesheets, ...
      #
      # @example Asset
      #   vendor/assets/images/image.png => images/image.png
      #   assets/css/all.scss            => css/all.scss
      #
      # @see {#load_components_from} To load bower components
      def load_from_path(base_path, output_directories: [], importable_files: [], loadable_files: [], ignorable_files: [])
        fail Errno::ENOENT, base_path unless FileTest.directory? base_path

        asset_dirs = %w(assets app app/assets vendor vendor/assets lib lib/assets)

        [base_path].product(asset_dirs).each do |base, asset|
          path = File.join(base, asset)

          load_from(
            path,
            output_directories: output_directories,
            importable_files: importable_files,
            loadable_files: loadable_files,
            ignorable_files: ignorable_files
          )
        end
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

      # Generic load from
      #
      # @param [String] base_path
      #   The directory to load assets from.
      #
      # @param [Hash] output_directories
      #   A hash containing information about the output directories. The key
      #   needs to be a regular expression matching the filename. The value is
      #   the output directory.
      #
      # @param [Array] include_filter
      #   A list of regular expressions. All matching assets are included, all
      #   other ones not.
      #
      # @param [Array] exclude_filter
      #   A list of regular expressions. All matching assets are not included.
      def load_from(base_path, output_directories:, loadable_files:, importable_files:, ignorable_files:)
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

          args = {}
          args[:source_path] = new_path
          args[:output_dir] = output_dir if output_dir

          asset = creator.new(**args)

          asset.loadable   = true if loadable_files.any? { |regexp| regexp === p }
          asset.importable = true if importable_files_db.any? { |regexp| regexp === p }

          add(asset)
        end
      end
    end
  end
end
