# encoding: utf-8
module Middleman
  module Presentation
    class PresentationHelper
      private

      attr_reader :helper_container

      public

      def initialize(helper_container)
        fail TypeError, Middleman::Presentation.t('errors.invalid_helper_module') if !helper_container.is_a?(Module) && !helper_container.is_a?(Proc)

        @helper_container = helper_container
      end

      # Return self as module
      def to_module
        if helper_container.is_a? Proc
          mod = Module.new
          mod.module_eval(&helper_container)

          mod
        else
          helper_container
        end
      end

      # Return name for container
      def name
        if helper_container.respond_to?(:name) && !helper_container.name.blank?
          helper_container.name
        else
          '<Anonymous>'
        end
      end

      # Type of helper
      def type
        if helper_container.is_a? Module
          :MODULE
        else
          :PROC
        end
      end

      # Return all available methods
      def available_methods
        instance_methods = to_module.instance_methods - Module.methods
        klass_methods = (to_module.methods - Module.methods).map { |m| "self.#{m}" }

        instance_methods + klass_methods
      end

      # Parse an array
      def self.parse(*modules)
        modules.flatten.map { |m| new(m) }
      end
    end
  end
end
