# encoding: utf-8
module Middleman
  module Presentation
    class SlideList

      private

      attr_accessor :slides

      public

      def initialize(names, slide_builder: NewSlide, &block)
        names = Array(names)
        @slides = names.map { |n| slide_builder.new(name: n) }

        fail ArgumentError, I18n.t('errors.duplicate_slide_names', slide_names: duplicates.map { |d| d.name }.to_list) unless duplicates.blank?

        block.call(self) if block_given?
      end

      def transform_with(transformer)
        self.slides = slides.map { |s| transformer.transform(s) }
      end

      def duplicates
        duplicate_slide = slides.find { |e| slides.count(e) > 1 }
       
        return [] if duplicate_slide.blank?

        slides.find_all { |s| s.basename == duplicate_slide.basename }
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
