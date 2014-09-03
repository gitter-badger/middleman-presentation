# encoding: utf-8
module Middleman
  module Presentation
    # Importable asset
    #  
    # An importable asset is either a stylesheet or a javascript file and can
    # be imported into `javascripts/application.js` or
    # `stylesheets/application.scss`.
    class ImportableAsset
      include Comparable

      private

      include FeduxOrgStdlib::Roles::Typable

      attr_reader :source_path

      # Create instance
      #
      # @param [String] source_path
      #   The source path for the asset
      #
      # @param [String] destination_directory
      #   The directory where the asset should be placed when building the
      #   static version of the web application
      def initialize(source_path:)
        @source_path = Pathname.new(source_path)
      end

      # Return import path
      # 
      # The import path is the real path without the file extension
      def import_path
        source_path.basename('.*')
      end

      # Is the ImportableAsset really importable
      def importable?
        valid? && (script? || stylesheet?)
      end
    end
  end
end
