# encoding: utf-8
module Middleman
  module Presentation
    # A frontend component
    class FrontendComponent
      attr_reader :name

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
      def initialize(resource_locator: nil, version: nil, name: nil, github: nil, javascripts: [], stylesheets: [])
        @resource_locator = if version
                              Class.new do
                                attr_reader :to_s

                                def initialize(value)
                                  @to_s = value
                                end
                              end.new(version)
                            elsif github
                              Addressable::URI.heuristic_parse format('https://github.com/%s.git', github)
                            elsif resource_locator =~ /\A#{URI.regexp}\z/
                              Addressable::URI.heuristic_parse resource_locator
                            else
                              nil
                            end

        fail ArgumentError, JSON.dump(message: I18n.t('errors.undefined_arguments', arguments: %w(resource_locator github version).to_list)) if @resource_locator.blank?

        @name = if version
                  name
                elsif name.blank?
                  File.basename(@resource_locator.path)
                else
                  name
                end

        fail ArgumentError, JSON.dump(message: I18n.t('errors.argument_error', argument: :name, value: @name)) if @name.blank?

        @javascripts = Array(javascripts)
        @stylesheets = Array(stylesheets)
      end

      # Return resource locator
      #
      # @return [String]
      #   The resource locator
      def resource_locator
        @resource_locator.to_s
      end

      # @!attribute [r] javascripts
      #   Return the paths to javascripts prepended with "name/"
      def javascripts
        @javascripts.map { |j| format '%s/%s', name, j }
      end

      # @!attribute [r] stylesheets
      #   Return the paths to stylesheets prepended with "name/"
      def stylesheets
        @stylesheets.map { |s| format '%s/%s', name, s }
      end
    end
  end
end
