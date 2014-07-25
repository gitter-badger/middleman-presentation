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

        def transform(slide)
          slide.path = File.join(base_path, slide.file_name)

          slide
        end
      end
    end
  end
end
