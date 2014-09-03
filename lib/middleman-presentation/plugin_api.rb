# encoding: utf-8
module Middleman
  module Presentation
    # Plugin Api
    module PluginApi
      # Add frontend component
      def add_component(*args)
        Middleman::Presentation.frontend_components_manager.add(*args)
      end

      # Add helpers
      #
      # @example Add helpers via modules
      #
      # add_helpers MyModule1, MyModule2
      #
      # @example Add helpers via code block
      #
      # add_helpers do
      #   def my_helper1
      #     'my_helper1'
      #   end
      # end
      def add_helpers(*m, &block)
        Middleman::Presentation.helpers_manager.add(*m, &block)
      end

      # Add assets which should be imported
      #
      # @param [String] path
      #   Directory where assets are stored
      def add_assets(path, output_directories: {}, exclude_filter: [], include_filter: [])
        Middleman::Presentation.assets_manager.load_from(path, output_directories: output_directories, exclude_filter: exclude_filter, include_filter: include_filter)
      end

      module_function :add_component, :add_helpers, :add_assets
    end
  end
end
