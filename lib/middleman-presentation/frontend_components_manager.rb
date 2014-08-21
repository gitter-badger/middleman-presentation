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

      # Return available frontend components
      def available_frontend_components
        frontend_components.to_a
      end

      # Add component
      def add(c)
        if c.blank?
          Middleman::Presentation.logger.warn I18n.t('errors.add_empty_frontend_component')
          return 
        end

        component = if c.is_a? FrontendComponent
                      c
                    elsif c.is_a? Array
                      FrontendComponent.parse(c)
                    else
                      FrontendComponent.new(**c)
                    end

        frontend_components << component
      end

      # List installed plugins
      def to_s
        data = frontend_components.reduce([]) do |a, e| 
          a << {
            name: e.name,
            resource_locator: e.resource_locator,
            version: e.version,
            javascripts: e.javascripts,
            stylesheets: e.stylesheets
          }
        end

        List.new(data).to_s
      end
    end
  end
end
