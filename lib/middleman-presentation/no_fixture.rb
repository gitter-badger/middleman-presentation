# encoding: utf-8
module Middleman
  module Presentation
    # Placeholder when no associated fixture found, displays warning
    class NoFixture
      private

      attr_reader :name

      public

      def initialize(name)
        @name = name
      end

      # Is not an existing plugin
      def blank?
        true
      end

      def method_missing(*_args)
        warn "Warning: The fixture '#{name}' was not found!"
      end
    end
  end
end
