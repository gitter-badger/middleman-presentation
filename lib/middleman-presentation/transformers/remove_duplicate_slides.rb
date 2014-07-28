# encoding: utf-8
module Middleman
  module Presentation
    module Transformers
      class RemoveDuplicateSlides
        private

        attr_reader :additional_slides, :raise_error

        public

        def initialize(additional_slides: [], raise_error: false)
          @additional_slides = additional_slides
          @raise_error       = raise_error
        end

        def transform(slides)
          temp_slides = (Array(slides) + Array(additional_slides)).uniq

          duplicate_slides = temp_slides.inject([]) do |memo, t|
            memo << slides.find_all do |s| 
              t.similar?(s) && !t.eql?(s) 
            end

            memo
          end.flatten

          fail ArgumentError, I18n.t('errors.duplicate_slide_names', slide_names: duplicate_slides.map(&:file_name).to_list) if !duplicate_slides.blank? and raise_error

          slides - duplicate_slides
        end
      end
    end
  end
end
