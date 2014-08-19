# encoding: utf-8
module Middleman
  module Presentation
    class FrontendComponentsManager

      private

      include Tablelize

      attr_reader :frontend_components

      public

      def initialize
        @frontend_components = Set.new
      end

      def add(c)
        component = if c.is_a? FrontendComponent
                      c
                    else
                      FrontendComponent.new(**c)
                    end

        frontend_components << component
      end

      def to_s
        table frontend_components.inject([]) { |a, e| a << Hash.new(name: e.name, homepage: e.hompage) }
      end
    end
  end
end
