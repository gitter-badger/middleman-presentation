# encoding: utf-8
module Middleman
  module Presentation
    class BowerDirectory
      private

      attr_reader :root_directory, :directory

      public

      def initialize(root_directory:, directory:)
        @root_directory = Pathname.new(root_directory)
        @directory      = Pathname.new(directory)
      end

      # Return absolute path to bower directory
      #
      # This is root + directory
      def absolute_path
        (root_directory + directory).expand_path
      end

      # Return relative path of bower directory
      #
      # This can be `vendor/assets/components` for example.
      def relative_path
        directory
      end
    end
  end
end
