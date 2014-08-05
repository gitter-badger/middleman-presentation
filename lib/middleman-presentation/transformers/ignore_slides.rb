# encoding: utf-8
module Middleman
  module Presentation
    module Transformers
      # Ignore slides in list: delete them from list
      class IgnoreSlides
        private

        attr_reader :ignore_file

        public

        def initialize(ignore_file:, ignore_file_builder: IgnoreFile)
          @ignore_file = ignore_file_builder.new(ignore_file)

          invalid_ignore_file = Pathname.new(ignore_file).dirname + Pathname.new('.slideignore')

          message = "Invalid ignore file \"#{invalid_ignore_file}\" detected. I'm going to ignore it. Please use the correct one \"#{ignore_file}\"."
          Middleman::Presentation.logger.warn message if invalid_ignore_file.exist?
        end

        def transform(slides)
          slides.delete_if { |slide| ignore_file.ignore? slide }
        end
      end
    end
  end
end
