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
    class FrontendComponent < Component

      attr_accessor :root_directory

      # Create new frontend component
      #
      # @see [Component] For all other params
      #
      # @param [String] root_directory
      #   The directory where all frontend components can be found
      def initialize(root_directory: nil, **args)
        super(**args)

        @resource_locator = if @resource_locator =~ /\A#{URI.regexp}\z/
                              Addressable::URI.heuristic_parse @resource_locator
                            elsif @github
                              Addressable::URI.heuristic_parse format('https://github.com/%s.git', @github)
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
        fail ArgumentError, Middleman::Presentation.t('errors.undefined_arguments', arguments: %w(resource_locator github version).to_list) if @resource_locator.blank?

        @name = if version
                  name
                elsif name.blank?
                  File.basename(@resource_locator.path)
                else
                  name
                end

        fail ArgumentError, Middleman::Presentation.t('errors.argument_error', argument: :name, value: @name) if @name.blank?

        @root_directory = root_directory
      end

      # Return path to component
      #
      # If root directory is set, it will be prepended to name.
      def path
        args = []
        args << root_directory if root_directory
        args << name.to_s

        File.join(*args)
      end

      # Base path for component
      def base_path
        File.dirname(path)
      end

      # Should middleman-presentation fetch the component
      def fetchable?
        !@resource_locator.blank?
      end
    end
  end
end
