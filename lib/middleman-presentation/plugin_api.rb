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

      module_function :add_component, :add_helpers
    end
  end
end
