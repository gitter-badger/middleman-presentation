# encoding: utf-8
module Middleman
  module Presentation
    class SlideList

      private

      attr_accessor :slides, :transformers

      public

      def initialize(names, slide_builder: NewSlide, &block)
        @slides = Array(names).map { |n| slide_builder.new(name: n) }
        @transformers = []

        block.call(self) if block_given?

        @slides = transformers.inject(@slides) { |memo, t| t.transform(memo) }
      end

      def transform_with(transformer)
        transformers << transformer
      end

      def all
        slides.uniq.dup
      end

      def each_new(&block)
        all.keep_if { |s| s.respond_to? :exist? and !s.exist? }.each(&block)
      end

      def existing_slides
        all.keep_if { |s| s.respond_to? :exist? and s.exist? }
      end
    end
  end
end
