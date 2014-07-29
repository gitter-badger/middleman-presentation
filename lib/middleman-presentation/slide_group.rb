# encoding: utf-8
module Middleman
  module Presentation
    class SlideGroup

      private

      attr_reader :template

      public

      attr_reader :name, :slides

      def initialize(name:, slides:, template:)
        @name     = name
        @slides   = slides
        @template = template
      end

      # Combine paths of all slides
      def partial_path
        slides.map(&:partial_path).to_list
      end

      # Call block for each slide
      def render(&block)
        slides_content = slides.inject([]) { |memo, s| memo << block.call(s.partial_path); memo }.join("\n")

        template.result(slides: slides_content)
      end

      # Is group
      def group?
        true
      end
    end
  end
end

