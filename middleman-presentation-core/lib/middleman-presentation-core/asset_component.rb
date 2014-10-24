# encoding: utf-8
module Middleman
  module Presentation
    # A asset component
    #
    # It represents a asset component. A asset component can contain
    # JavaScript-files, stylesheets, images, fonts, ... . A asset component
    # knows where to get a the files from in filesystem, which version of the
    # component is required and which JavaScript-files and stylesheets should
    # be includes in "javascripts/application.js" and
    # "stylesheets"application.scss".
    class AssetComponent < Component
      attr_reader :path, :base_path

      # An asset component
      #
      # @see [Component] For all other params
      #
      # @param [String] path
      #   The directory where all assets files can be found which belong to this component
      def initialize(path:, **args)
        super(**args)

        @path = @name = @base_path = path
      end

      def root_directory=(val); end
    end
  end
end
