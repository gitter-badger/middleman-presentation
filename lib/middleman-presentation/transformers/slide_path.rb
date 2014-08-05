# encoding: utf-8
module Middleman
  module Presentation
    module Transformers
      # Determine path of slide
      class SlidePath
        private

        attr_reader :slides_directory

        public

        def initialize(slides_directory)
          @slides_directory = slides_directory
        end

        def transform(slides)
          slides.map do |slide|
            path_parts = []
            path_parts << slides_directory
            path_parts << slide.group if slide.group

            path_parts << if slide.type? :erb
                            "#{slide.basename}.html.erb"
                          elsif slide.type? :md
                            "#{slide.basename}.html.md"
                          elsif slide.type? :liquid
                            "#{slide.basename}.html.liquid"
                          else
                            "#{slide.basename}.html"  # custom slide => file extension depends on template and is set later by template finder
                          end

            slide.path = File.join(*path_parts)

            partial_path = []
            partial_path << File.basename(slides_directory)
            partial_path << slide.group if slide.group
            partial_path << slide.basename

            slide.partial_path = File.join(*partial_path)

            relative_path = []
            relative_path << File.basename(File.dirname(slides_directory))
            relative_path << File.basename(slides_directory)
            relative_path << slide.group if slide.group
            relative_path << slide.file_name

            slide.relative_path = File.join(*relative_path)

            slide
          end
        end
      end
    end
  end
end
