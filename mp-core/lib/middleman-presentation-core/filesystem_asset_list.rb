# encoding: utf-8
module Middleman
  module Presentation
    class FilesystemAssetList < AssetList
      private

      attr_reader :output_directories, :loadable_files, :importable_files, :ignorable_files

      def initialize(directory:, output_directories: [], loadable_files: [], importable_files: [], ignorable_files: [], **args)
        @output_directories = output_directories
        @loadable_files     = loadable_files
        @importable_files   = importable_files
        @ignorable_files    = ignorable_files

        super(directory: directory, **args)
      end

      private

      def read_in_assets
        add_assets(
          directory,
          output_directories: output_directories, 
          loadable_files: loadable_files,
          importable_files: importable_files,
          ignorable_files: ignorable_files
        )
      end
    end
  end
end
