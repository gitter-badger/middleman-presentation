# encoding: utf-8
module Middleman
  module Presentation
    class FrontendComponent
      attr_reader :name, :javascripts, :stylesheets

      class << self
        # Parse line
        #
        # @param [Array, String] hashes
        #   Options read from config file
        def parse(*hashes)
          results = hashes.flatten.map { |h| new(**h) }

          return results.first if results.size == 1

          results
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
      def initialize(resource_locator: nil, name: nil, github: nil, javascripts: [], stylesheets: [])
        @resource_locator = if github
                             Addressable::URI.heuristic_parse format('https://github.com/%s.git', github)
                           elsif resource_locator =~ /\A#{URI::regexp}\z/
                             Addressable::URI.heuristic_parse resource_locator
                           elsif resource_locator == nil and github == nil
                             nil
                           else
                             OpenStruct.new(path: resource_locator, to_s: resource_locator)
                           end

        raise ArgumentError, JSON.dump(message: I18n.t('errors.undefined_arguments', arguments: %w{resource_locator github}.to_list)) if @resource_locator.blank?

        @name = if name.blank?
                  File.basename(@resource_locator.path)
                else
                  name
                end

        raise ArgumentError, JSON.dump(message: I18n.t('errors.argument_error', argument: :name, value: @name)) if @name.blank?

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
    end
  end
end
