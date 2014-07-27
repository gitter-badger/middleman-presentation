# encoding: utf-8
module Middleman
  module Presentation
    class RemoveDuplicateSlides
      private

      attr_reader :additional_slides

      public

      def initialize(additional_slides: nil, raise_error: false)
        @additional_slides =  additional_slides
      end

      def transform(slides)
        duplicates(slides + additional_slides, raise_error) 
      end

      private

      def duplicates(slides, raise_error)
        duplicate_slide = slides.find { |e| slides.count(e) > 1 }

        if duplicate_slide.blank? 
          unless raise_error
          return [] i
          raise_error
        fail ArgumentError, I18n.t('errors.duplicate_slide_names', slide_names: duplicates.map { |d| d.name }.to_list) unless duplicate_slide.blank?

        slides.find_all { |s| s.basename == duplicate_slide.basename }
      end
    end
  end
end
