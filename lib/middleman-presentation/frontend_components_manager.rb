# encoding: utf-8
module Middleman
  module Presentation
    # Frontend Component Manager
    class FrontendComponentsManager
      private

      attr_reader :frontend_components, :creator

      public

      def initialize(creator: FrontendComponent)
        @frontend_components = Set.new
        @creator = creator
      end

      # Return available frontend components
      def available_frontend_components
        frontend_components.to_a
      end

      # Add component
      def add(c)
        if c.blank?
          Middleman::Presentation.logger.warn Middleman::Presentation.t('errors.add_empty_frontend_component')
          return
        end

        component = if c.is_a? creator
                      c
                    elsif c.is_a? Array
                      creator.parse(c)
                    elsif c.respond_to? :to_h
                      creator.new(**c.to_h)
                    else
                      fail ArgumentError, Middleman::Presentation.t('errors.invalid_frontend_component')
                    end

        frontend_components <<  component
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

        List.new(data).to_s(fields: [:name, :resource_locator, :version, :javascripts, :stylesheets])
      end
    end
  end
end
