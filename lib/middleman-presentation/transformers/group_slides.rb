# encoding: utf-8
module Middleman
  module Presentation
    module Transformers
      class GroupSlides

        private

        attr_reader :template

        public

        def initialize(template:)
          @template = template
        end

        def transform(slides)
          groups = Set.new

          new_slides = slides.map do |slide|
            if slide.group and groups.none? { |g| g.name == slide.group }
              slide = group = SlideGroup.new name: slide.group, slides: slides.find_all { |s| s.has_group? slide.group }, template: template
              groups << group
            end

            slide
          end

          new_slides - groups.collect { |g| g.slides }.flatten
        end
      end
    end
  end
end
