# encoding: utf-8
module Middleman
  module Presentation
    class RemoveDuplicates
      def transform(slides)
      end

      private

      def duplicates(slides)
        duplicate_slide = slides.find { |e| slides.count(e) > 1 }

        return [] if duplicate_slide.blank?

        slides.find_all { |s| s.basename == duplicate_slide.basename }
      end
    end
  end
end
