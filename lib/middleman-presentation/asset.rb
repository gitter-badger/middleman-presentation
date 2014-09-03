# encoding: utf-8
module Middleman
  module Presentation
    # External asset
    #
    # It represents a single asset - an image, a stylesheets, a font etc. An
    # assets will be placed in a default directory by `middleman-sprockes`. To
    # change the default directory one needs to tell the `Asset`-class that on
    # initialization.
    class Asset
      include Comparable
      include FeduxOrgStdlib::Roles::Typable

      attr_reader :source_path, :destination_directory

      # Create instance
      #
      # @param [String] source_path
      #   The source path for the asset
      #
      # @param [String] destination_directory
      #   The directory where the asset should be placed when building the
      #   static version of the web application
      def initialize(source_path:, destination_directory:)
        @source_path           = source_path.blank? ? nil : Pathname.new(source_path)
        @destination_directory = destination_directory.blank? ? nil : Pathname.new(destination_directory)
      end

      # Destination path resolver
      def destination_path_resolver
        return proc { |local_path| destination_directory + local_path } if destination_directory

        proc {}
      end

      # @private
      def hash
        source_path.hash
      end

      # @private
      def eql?(other)
        source_path.eql? other.source_path
      end

      # @private
      def <=>(other)
        source_path <=> other.source_path
      end
    end
  end
end
