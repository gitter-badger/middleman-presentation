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
      private

      attr_reader :root_directory

      public

      # Create new frontend component
      #
      # @see [Component] For all other params
      #
      # @param [String] root_directory
      #   The directory where all frontend components can be found
      def initialize(root_directory: nil, **args)
        super(**args)

        @root_directory = root_directory
      end

      # Return path to component
      #
      # If root directory is set, it will be prepended to name.
      def path
        args = []
        args << root_directory if root_directory
        args << name

        File.join(*args)
      end

      # Should middleman-presentation fetch the component
      def fetchable?
        !@resource_locator.blank?
      end
    end
  end
end
