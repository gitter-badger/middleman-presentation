# encoding: utf-8
module Middleman
  module Presentation
    module Transformers
      class IgnoreSlides

        private

        attr_reader :ignore_file

        public

        def initialize(ignore_file:, ignore_file_builder: IgnoreFile)
          @ignore_file = ignore_file_builder.new(ignore_file)
        end

        def transform(slides)
          slides.delete_if { |slide| ignore_file.ignore? slide }
        end
      end
    end
  end
end
