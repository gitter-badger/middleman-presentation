# encoding: utf-8
module Middleman
  module Presentation
    class FrontendComponentAssetList < AssetList
      private

      attr_reader :components

      public

      def initialize(components:, directory:, **args)
        @components = Array(components)
        @directory  = directory
        @creator    = creator

        super(directory: directory, **args)
      end

      private

      def read_in_assets
        components.each do |c|
          add_assets(
            directory, 
            output_directories: c.output_directories, 
            loadable_files: c.loadable_files,
            importable_files: c.importable_files,
            ignorable_files: c.ignorable_files
          )
        end
      end
    end
  end
end
