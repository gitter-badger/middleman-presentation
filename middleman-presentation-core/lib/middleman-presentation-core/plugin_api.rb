# encoding: utf-8
module Middleman
  module Presentation
    # Plugin Api
    module PluginApi
      # Require some other plugin
      #
      # @param [String, Array] names
      #   The name of the plugin which should be loaded. It also supports
      #   multiple arguments or an array of plugin names.
      #
      # @example String
      #
      #   require_plugin 'name1'
      #
      # @example Multiple Arguments
      #
      #   require_plugin 'name1', 'name2'
      #
      # @example Arrays
      #
      #   require_plugin ['name1', 'name2']
      #
      def require_plugin(*names)
        application.plugins_manager.activate_plugin(names)
      end

      # Add frontend component
      #
      # @param [Hash] component
      #   The component which should be added
      def add_component(component)
        Middleman::Presentation.frontend_components_manager.add(component)
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
      # def add_assets(path, output_directories: {}, importable_files: [], loadable_files: [], ignorable_files: [])
      def add_assets(*args)
        Middleman::Presentation.asset_components_manager.add(*args)
      end

      module_function :add_component, :add_helpers, :add_assets
    end
  end
end
