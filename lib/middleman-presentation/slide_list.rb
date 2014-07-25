# encoding: utf-8
module Middleman
  module Presentation
    class SlideList

      private

      attr_accessor :slides

      public

      def initialize(names, slide_builder: NewSlide, &block)
        @slides = Array(names).map { |n| slide_builder.new(name: n) }

        block.call(self) if block_given?
          #invoke('slide:create', names - candidates, title: options[:title]) if candidates.size != names.size
      end

      def transform_with(transformer)
        self.slides = slides.map { |s| transformer.transform(s) }
      end

      def all
        slides.dup
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
