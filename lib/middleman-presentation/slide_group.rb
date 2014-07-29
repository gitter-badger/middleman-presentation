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

      def partial_path
        group_file.path
      end

      def group?
        true
      end

      private

      def slides_content
        slides.inject([]) { |memo, s| memo << s.content; memo }.join("\n")
      end

      def group_file
        return @file if @file
     
        @file = Tempfile.new("_#{SecureRandom.hex}")
        @file.write template.result slides: slides_content
        @file.rewind

        @file
      end
    end
  end
end

