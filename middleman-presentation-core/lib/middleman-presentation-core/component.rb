# encoding: utf-8
module Middleman
  module Presentation
    # A component
    class Component
      include Comparable

      attr_reader :name, :resource_locator, :version, :importable_files, :loadable_files, :ignorable_files, :output_paths

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
      # rubocop:disable Metrics/ParameterLists
      def initialize(
        resource_locator: nil,
        version: nil,
        name: nil,
        github: nil,
        importable_files: [],
        loadable_files: [],
        ignorable_files: [],
        output_paths: []
      )

        @name               = name
        @resource_locator   = resource_locator
        @version            = version
        @github             = github
        @loadable_files     = Array(loadable_files).map { |o| Regexp.new o }
        @importable_files   = Array(importable_files).map { |o| Regexp.new o }
        @ignorable_files    = Array(ignorable_files).map { |o| Regexp.new o }
        @output_paths       = Array(output_paths)
      end
      # rubocop:enable Metrics/ParameterLists

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

      # Configure accessor for root directory
      def root_directory
        fail NoMethodError, :root_directory
      end

      # Configure accessor for root directory
      def root_directory=(*)
        fail NoMethodError, :root_directory=
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
        name.to_s <=> other.name.to_s
      end
    end
  end
end
