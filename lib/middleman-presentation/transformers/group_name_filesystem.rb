# encoding: utf-8
module Middleman
  module Presentation
    module Transformers
      # Set group name based on filesystem information
      class GroupNameFilesystem
        private

        attr_reader :base_path

        public

        def initialize(base_path)
          @base_path = base_path
        end

        def transform(slides)
          slides.map do |slide|
            slide.name, slide.group = extract_group_name(slide)

            slide
          end
        end

        private

        def extract_group_name(slide)
          name, group  = Pathname.new(slide.name).relative_path_from(Pathname.new(base_path)).split.reverse.map { |s| s.to_s.gsub(/\//, ':') }

          group = if group == '.'
                    nil
                  else
                    group
                  end

          [name, group]
        end
      end
    end
  end
end
