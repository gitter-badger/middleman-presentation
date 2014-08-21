# encoding: utf-8
module Middleman
  module Presentation
    module Plugable
      # @see PluginApi.add_assets 
      def add_assets(*args, &block)
        PluginApi.add_assets(*args, &block)
      end

      # @see PluginApi.add_component
      def add_component(*args, &block)
        PluginApi.add_component(*args, &block)
      end

      # @see PluginApi.add_helpers
      def add_helpers(*args, &block)
        PluginApi.add_helpers(*args, &block)
      end
    end
  end
end
