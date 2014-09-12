# encoding: utf-8
module Middleman
  module Presentation
    class FilesystemAssetList < AssetList
      private

      attr_reader :output_directories, :loadable_files, :importable_files, :ignorable_files

      def initialize(directory:, output_directories: [], loadable_files: [], importable_files: [], ignorable_files: [], creator: nil)
        @output_directories = output_directories
        @loadable_files     = loadable_files
        @importable_files   = importable_files
        @ignorable_files    = ignorable_files

        args = {}
        args[:directory] = directory
        args[:creator]   = creator unless creator.blank?

        super(**args)
      end

      private

      def to_a
        to_assets(
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
