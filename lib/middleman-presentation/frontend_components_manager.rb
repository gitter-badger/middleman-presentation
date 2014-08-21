# encoding: utf-8
module Middleman
  module Presentation
    # Frontend Component Manager
    class FrontendComponentsManager
      private

      attr_reader :frontend_components

      public

      def initialize
        @frontend_components = Set.new
      end

      # Add component
      def add(c)
        component = if c.is_a? FrontendComponent
                      c
                    elsif c.is_a? Array
                      FrontendComponent.parse(c)
                    else
                      FrontendComponent.new(**c)
                    end

        frontend_components << component
      end

      # Array of requested frontend components
      def to_a
        frontend_components.reduce([]) do |a, e| 
          a << {
            name: e.name,
            resource_locator: e.resource_locator,
            version: e.version,
            javascripts: e.javascripts,
            stylesheets: e.stylesheets
          }
        end
      end

      # List installed plugins
      def to_s
        List.new(to_a).to_s
      end
    end
  end
end
