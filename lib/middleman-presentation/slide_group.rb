# encoding: utf-8
module Middleman
  module Presentation
    class SlideGroup

      public

      attr_reader :name, :slides, :header, :footer

      def initialize(name:, slides:, header:, footer:)
        @name     = name
        @slides   = slides
        @header   = File.read(header).chomp
        @footer   = File.read(footer).chomp
      end

      def partial_path
        slides.map(&:partial_path).to_list
      end

      def group?
        true
      end
    end
  end
end

