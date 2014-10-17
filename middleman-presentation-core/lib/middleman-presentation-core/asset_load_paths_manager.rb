# encoding: utf-8
module Middleman
  module Presentation
    class AssetLoadPathsManager
      private

      attr_reader :load_paths

      public

      def initialize
        @load_paths = Set.new
      end

      # Add path
      def add(path)
        load_paths << path
      end

      # Iterate over each path
      def each_path(&block)
        load_paths.each(&block)
      end
    end
  end
end
