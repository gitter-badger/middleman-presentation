# encoding: utf-8
module Middleman
  module Presentation
    # A frontend component
    #
    # It represents a bower component. A bower component can contain
    # JavaScript-files, stylesheets, images, fonts, ... . A frontend component
    # know where to get a bower component from, which version of the component
    # is required and which JavaScript-files and stylesheets should be includes
    # in "javascripts/application.js" and "stylesheets"application.scss".
    class FrontendComponent
      include Comparable

      private

      attr_reader :components_directory

      public

      attr_reader :name, :resource_locator, :version, :importable_files, :loadable_files, :ignorable_files
      attr_writer :components_directory

      class << self
        # Parse line
        #
        # @param [Array, String] hashes
        #   Options read from config file
        def parse(*hashes)
          hashes.flatten.map { |h| new(**h) }
        end
      end

      # Create new frontend component
      #
      # @param [String] resource_locator
      #   The locator to look for the resource, e.g. http://example.org/test or latest
      #
      # @param [String] name (nil)
      #   Alternative name for the resource, otherwise the base name of the resource_locator's path is used: http://example.org/test => test
      #
      # @param [String] github
      #   Name of github repository, e.g. <account>/<repository>
      def initialize(resource_locator: nil, version: nil, name: nil, github: nil, importable_files: [], loadable_files: [], ignorable_files: [])
        @resource_locator = if resource_locator =~ /\A#{URI.regexp}\z/
                              Addressable::URI.heuristic_parse resource_locator
                            elsif github
                              Addressable::URI.heuristic_parse format('https://github.com/%s.git', github)
                            elsif version
                              Class.new do
                                attr_reader :to_s

                                def initialize(value)
                                  @to_s = value
                                end
                              end.new(version)
                            else
                              nil
                            end
        @version = version

        fail ArgumentError, Middleman::Presentation.t('errors.undefined_arguments', arguments: %w(resource_locator github version).to_list) if @resource_locator.blank?

        @name = if version
                  name
                elsif name.blank?
                  File.basename(@resource_locator.path)
                else
                  name
                end

        fail ArgumentError, Middleman::Presentation.t('errors.argument_error', argument: :name, value: @name) if @name.blank?

        @loadable_files   = Array(loadable_files)
        @importable_files = Array(importable_files)
        @ignorable_files  = Array(ignorable_files)
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
