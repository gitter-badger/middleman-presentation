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

      attr_reader :assets, :creator

      public

      def initialize(creator: Asset)
        @assets          = Set.new
        @creator         = creator
      end

      # Add asset
      def add(a)
        assets << creator.new(**a)
      end

      # Show assets which should be imported
      def to_s
        data = assets.sort.reduce([]) do |a, e|
          a << { source_path: e.source_path, destination_directory: e.destination_directory }
        end

        List.new(data).to_s(fields: [:source_path, :destination_directory])
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
      def load_from_path(base_path, output_directories: [], include_filter: [], exclude_filter: [])
        fail Errno::ENOENT, base_path unless FileTest.directory? base_path

        asset_dirs = %w(assets app app/assets vendor vendor/assets lib lib/assets)

        [base_path].product(asset_dirs).each do |base, asset|
          path = File.join(base, asset)

          load_from(
            path,
            output_directories: output_directories,
            include_filter: include_filter,
            exclude_filter: exclude_filter
          )
        end
      end

      # Iterate over each importable asset
      def each_importable_asset(&block)
        assets.dup.each(&block)
      end

      # Iterate over each importable asset
      def each_includable_stylesheet(&block)
        assets.find_all { |a| a.valid? && a.stylesheet? }.each(&block)
      end

      # Iterate over each importable asset
      def each_includable_javascript(&block)
        assets.find_all { |a| a.valid? && a.script? }.each(&block)
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
      def load_from(base_path, output_directories:, include_filter:, exclude_filter:)
        base_path   = File.expand_path(base_path)
        search_path = File.join(base_path, '**', '*')

        Dir.glob(search_path).sort.each do |p|
          next unless File.file? p

          # rubocop:disable Style/CaseEquality
          next if !include_filter.blank? && Array(include_filter).none? { |f| Regexp.new(f) === p }
          next if !exclude_filter.blank? && Array(exclude_filter).any? { |f| Regexp.new(f) === p }
          # rubocop:enable Style/CaseEquality

          new_path   = File.join(*Pathname.new(p).relative_path_from(Pathname.new(base_path)).each_filename.to_a)

          # assets will be find multiple times: vendor/ will find assets in vendor/assets as well
          next if new_path.to_s.start_with?('assets')

          # rubocop:disable Style/CaseEquality
          output_dir = output_directories.find(proc { [] }) { |pattern, _| pattern === p }.last
          # rubocop:enable Style/CaseEquality

          args = []
          args << new_path
          args << output_dir if output_dir

          add(*args)
        end
      end
    end
  end
end
