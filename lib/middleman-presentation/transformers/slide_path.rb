# encoding: utf-8
module Middleman
  module Presentation
    module Transformers
      class SlidePath

        private

        attr_reader :base_path

        public

        def initialize(base_path)
          @base_path = base_path
        end

        def transform(slides)
          slides.map do |slide|
            path_parts = []
            path_parts << base_path
            path_parts << slide.group if slide.group

            if slide.has_extname? '.erb'
              path_parts << "#{slide.basename}.erb"

              slide.path = File.join(*path_parts)
              slide.type = :erb
            elsif slide.has_extname? '.md', '.markdown', '.mkd'
              path_parts << "#{slide.basename}.md"

              slide.path = File.join(*path_parts)
              slide.type = :md
            elsif slide.has_extname? '.l', '.liquid'
              path_parts << "#{slide.basename}.liquid"

              slide.path = File.join(*path_parts)
              slide.type = :liquid
            else
              path_parts << "#{slide.basename}.md"

              slide.path = File.join(*path_parts)
              slide.type = :md
            end

            partial_path = []
            partial_path << File.basename(base_path)
            partial_path << slide.group if slide.group
            partial_path << slide.basename

            slide.partial_path = File.join(*partial_path)

            slide
          end
        end
      end
    end
  end
end
