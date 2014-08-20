# encoding: utf-8
module Middleman
  module Presentation
    # Manager for helper modules
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
        fail TypeError, I18n.t('errors.invalid_helper_module') unless modules.all? { |m| m.is_a? Module }

        if block_given?
          mod = Module.new
          mod.module_eval(&block)
          modules += [mod]
        end

        self.helper_modules = helper_modules + modules
      end

      # Return available helpers
      def available_helpers
        helper_modules.reduce(Module.new) { |a, e| a.include e }
      end

      # Show helper modules
      def to_s
        data = helper_modules.reduce([]) do |a, e|
          a << { name: e.respond_to?(:name) ? e.name : 'Anonymous' }
        end

        List.new(data).to_s
      end
    end
  end
end
