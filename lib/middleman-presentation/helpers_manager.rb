# encoding: utf-8
module Middleman
  module Presentation
    class HelpersManager

      private

      attr_reader :helper_modules

      protected

      attr_writer :helper_modules

      public

      def initialize
        @helper_modules = []
      end

      # Add helpers
      def add(*modules, &block)

        if block_given?
          mod = Module.new
          mod.module_eval(&block)
          modules += [mod]
        end

        self.helper_modules = helper_modules + modules
      end

      # Return available helpers
      def available_helpers
        helper_modules
      end

      # Show helper modules
      def to_s
        table helper_modules.inject([]) { |a, e| a << Hash.new(name: e.name) }
      end
    end
  end
end
