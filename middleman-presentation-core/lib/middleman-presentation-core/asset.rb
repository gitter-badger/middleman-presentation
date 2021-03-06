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

      private

      attr_reader :importable, :loadable

      public

      attr_reader :source_path, :destination_path, :relative_source_path
      attr_writer :importable, :loadable

      # Create instance
      #
      # @param [String] source_path
      #   The source path for the asset
      #
      # @param [String] destination_path
      #   The directory where the asset should be placed when building the
      #   static version of the web application
      def initialize(source_path:, relative_source_path:, destination_path:, importable: false, loadable: false)
        @source_path          = Pathname.new(source_path)
        @relative_source_path = Pathname.new(relative_source_path)
        @importable           = importable
        @loadable             = loadable

        self.destination_path = destination_path
      end

      def import_path
        relative_source_path.dirname + relative_source_path.basename('.*')
      end

      def load_path
        relative_source_path
      end

      def destination_path=(value)
        @destination_path = value.blank? ? nil : Pathname.new(value)
      end

      # Destination path resolver
      def destination_path_resolver
        return proc { |_| destination_path } if destination_path

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

      # Is this asset importable?
      #
      # If it is importable, one can use it in `application.js` or
      # `application.scss`.
      #
      # @return [true, false]
      #   The result of check
      def importable?
        importable == true
      end

      # Is this asset loadable?
      #
      # If it is importable, it will be placed in build directory by sprockets.
      #
      # @return [true, false]
      #   The result of check
      def loadable?
        loadable == true
      end

      # Merge data from other asset
      def merge!(other)
        self.importable            = true if other.importable?
        self.loadable              = true if other.loadable?
        self.destination_path = other.destination_path if destination_path.blank?
      end
    end
  end
end
