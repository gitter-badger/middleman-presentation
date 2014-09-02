# encoding: utf-8
module Middleman
  module Presentation
    module Utils
      # Create zip archive from directory
      #
      # @param [String] source_directory
      #   The source directory
      #
      # @param [String] destination_file
      #   The zip file which should be created
      #
      # @param [String] prefix
      #   A prefix for the zip file, e.g. dir1/dir2/ => dir1/dir2/zip_file.
      #   Please mind the trailing '/'.
      def zip(source_directory, destination_file, prefix: nil)
        Zip.setup do |c|
          c.on_exists_proc          = true
          c.continue_on_exists_proc = true
          c.unicode_names           = true
          c.default_compression     = Zlib::BEST_COMPRESSION
        end

        Zip::File.open(destination_file, Zip::File::CREATE) do |file|
          Dir.glob(File.join(source_directory, '**', '*')).each do |filename|

            path = ''
            path << prefix if prefix
            path << filename

            file.add(path, filename)
          end
        end
      end

      module_function :zip
    end
  end
end
