# encoding: utf-8
module Middleman
  module Presentation
    # List of slides
    class SlideList
      include Enumerable

      private

      attr_accessor :transformers, :slides

      public

      def initialize(names, slide_builder:, **args, &block)
        @slides = Array(names).map { |n| slide_builder.new(n, **args) }
        @transformers = []

        block.call(self) if block_given?

        @slides = transformers.reduce(@slides) { |a, e| e.transform(a) }
      end

      def transform_with(transformer)
        transformers << transformer
      end

      def all
        slides.dup
      end

      def each(&block)
        slides.each(&block)
      end

      def each_new(&block)
        all.keep_if { |s| s.respond_to?(:exist?) && !s.exist? }.each(&block)
      end

      def each_existing(&block)
        all.keep_if { |s| s.respond_to?(:exist?) && s.exist? }.each(&block)
      end

      def existing_slides
        all.keep_if { |s| s.respond_to?(:exist?) && s.exist? }
      end

      def to_a
        all
      end
    end
  end
end
