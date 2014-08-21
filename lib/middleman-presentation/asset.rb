# encoding: utf-8
module Middleman
  module Presentation
    # External asset
    class Asset
      include Comparable

      private

      attr_reader :destination_directory

      public

      attr_reader :source_path

      def initialize(source_path:, destination_directory:)
        @source_path           = source_path.blank? ? nil : Pathname.new(source_path)
        @destination_directory = destination_directory.blank? ? nil : Pathname.new(destination_directory)
      end

      # Destination path
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
