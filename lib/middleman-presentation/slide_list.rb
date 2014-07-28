# encoding: utf-8
module Middleman
  module Presentation
    class SlideList

      private

      attr_accessor :transformers

      public

      def initialize(names, slide_builder: Slide, &block)
        @slides = Array(names).map { |n| slide_builder.new(name: n) }
        @transformers = []

        block.call(self) if block_given?

        @slides = transformers.inject(@slides) { |memo, t| t.transform(memo) }
      end

      def transform_with(transformer)
        transformers << transformer
      end

      def all
        @slides.dup
      end

      def each_new(&block)
        all.keep_if { |s| s.respond_to? :exist? and !s.exist? }.each(&block)
      end

      def existing_slides
        all.keep_if { |s| s.respond_to? :exist? and s.exist? }
      end

      def to_a
        all
      end
    end
  end
end
