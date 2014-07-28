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
        duplicate_slides = slides.find { |e| slides.count(e) > 1 }

        fail ArgumentError, I18n.t('errors.duplicate_slide_names', slide_names: duplicate_slides.map(&:name).to_list) if duplicate_slides.blank? and raise_error
        return [] if duplicate_slides.blank? 

        slides.find_all { |s| s.basename == duplicate_slides.basename }
      end
    end
  end
end
