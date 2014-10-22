# encoding: utf-8
module Middleman
  module Presentation
    # A component
    class Component
      include Comparable

      attr_reader :name, :resource_locator, :version, :importable_files, :loadable_files, :ignorable_files, :output_directories

      class << self
        # Parse line
        #
        # @param [Array, String] hashes
        #   Options read from config file
        def parse(*hashes)
          hashes.flatten.map { |h| new(**h) }
        end
      end

      # Create new component
      #
      # @param [String] resource_locator
      #   The locator to look for the resource, e.g. http://example.org/test or latest
      #
      # @param [String] name (nil)
      #   Alternative name for the resource, otherwise the base name of the resource_locator's path is used: http://example.org/test => test
      #
      # @param [String] github
      #   Name of github repository, e.g. <account>/<repository>
      def initialize(
        resource_locator: nil,
        version: nil,
        name: nil,
        github: nil,
        importable_files: [],
        loadable_files: [],
        ignorable_files: [],
        output_directories: []
      )

        @name               = name
        @resource_locator   = resource_locator
        @version            = version
        @github             = github
        @loadable_files     = Array(loadable_files).map { |o| Regexp.new o }
        @importable_files   = Array(importable_files).map { |o| Regexp.new o }
        @ignorable_files    = Array(ignorable_files).map { |o| Regexp.new o }
        @output_directories = Array(output_directories)
      end

      # Return path to component
      #
      # If root directory is set, it will be prepended to name.
      def path
        fail NoMethodError, :path
      end

      # Base path for component
      #
      # The path where the component can be found.
      def base_path
        fail NoMethodError, :base_path
      end

      # Should middleman-presentation fetch the component
      def fetchable?
        false
      end

      # Return resource locator
      #
      # @return [String]
      #   The resource locator
      def resource_locator
        @resource_locator.to_s
      end

      # @private
      def <=>(other)
        name <=> other.name
      end
    end
  end
end
