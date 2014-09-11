# encoding: utf-8
module Middleman
  module Presentation
    class FrontendComponentAssetList < AssetList
      private

      attr_reader :components

      public

      def initialize(components:, directory:, creator: Asset)
        @components = Array(components)
        @directory  = directory
        @creator    = creator
      end

      private

      def to_a
        components.reduce([]) do |a, c|  
          to_assets(
            File.join(directory, c.name), 
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
