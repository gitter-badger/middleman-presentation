# encoding: utf-8
module Middleman
  module Presentation
    class Cache
      include Enumerable

      private

      attr_reader :store
      attr_accessor :clean

      public

      def initialize(store: [])
        @store = store
        @clean = true
      end

      def add(obj)
        store << obj
        self.clean = false

        self
      end
      
      def mark_dirty
        self.clean = false

        self
      end

      def map(&block)
        return @cache if clean

        self.clean = true

        @cache = store.map(&block)
      end
    end
  end
end
