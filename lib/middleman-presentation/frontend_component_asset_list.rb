# encoding: utf-8
module Middleman
  module Presentation
    class FrontendComponentAssetList
      private

      attr_reader :components, :components_directory, :creator

      public

      def initialize(components:, components_directory:, creator: Asset)
        @components           = components
        @components_directory = components_directory
        @creator              = creator
      end

      def to_a
        components.reduce([]) do |a, c|  
          load_from(
            File.join(components_directory, c.name), 
            output_directories: c.output_directories, 
            loadable_files: c.loadable_files,
            importable_files: c.importable_files,
            ignorable_files: c.ignorable_files
          )
        end
      end

      private

      def load_from(base_path, output_directories:, loadable_files:, importable_files:, ignorable_files:)
        result      = Set.new
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
          args[:source_path]           = new_path
          args[:destination_directory] = output_dir

          asset = creator.new(**args)

          asset.loadable   = true if loadable_files.any? { |regexp| regexp === p }
          asset.importable = true if importable_files_db.any? { |regexp| regexp === p }

          result << asset
        end

        result
      end
    end
  end
end
