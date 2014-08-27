# encoding: utf-8
module Middleman
  module Presentation
    # Manager for helper modules
    class HelpersManager
      private

      attr_reader :presentation_helpers

      public

      def initialize(creator: PresentationHelper) 
        @presentation_helpers = []
      end

      # Add helpers
      def add(*modules, &block)
        presentation_helpers.concat PresentationHelper.parse(modules)
        presentation_helpers << PresentationHelper.new(block) if block_given?
      end

      # Return available helpers
      def available_helpers
        presentation_helpers.reduce(Module.new) { |a, e| a.include e.to_module }
      end

      # Show helper modules
      def to_s
        data = presentation_helpers.sort.reduce([]) do |a, e|
          a << { name: e.name, type: e.type, available_methods: e.available_methods.to_list }
        end

        List.new(data).to_s(fields: [:name, :type, :available_methods])
      end
    end
  end
end
