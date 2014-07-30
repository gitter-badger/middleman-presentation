# encoding: utf-8
module Middleman
  module Presentation
    module Transformers
      class GroupNameCmdline
        def transform(slides)
          slides.map do |slide|
            slide.name, slide.group  = extract_group_name(slide)

            slide
          end
        end

        private

        def extract_group_name(slide)
          result = slide.name.split(%r{:|/})

          name = result.pop
          group = result.join(':')
          group = if group.blank?
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
