# encoding: utf-8
module Middleman
  module Presentation
    # Plugin Api
    module PluginApi
      # Add frontend component
      def add_component(**args)
        Middleman::Presentation.component_manager.register(**args)
      end

      # Add helper
      def add_helper(&block)
        Middleman::Presentation.helper_manager.register(&block)
      end

      module_function :add_component, :add_helper
    end
  end
end
