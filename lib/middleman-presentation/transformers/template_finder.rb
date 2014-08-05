# encoding: utf-8
module Middleman
  module Presentation
    module Transformers
      # Find template for slide
      class TemplateFinder
        private

        attr_reader :base_path

        public

        def initialize(base_path)
          @base_path = base_path
        end

        def transform(slides)
          slides.map do |slide|
            if slide.type? :erb
              template_file = ErbTemplate.new(working_directory: base_path)
            elsif slide.type? :md
              template_file = MarkdownTemplate.new(working_directory: base_path)
            elsif slide.type? :liquid
              template_file = LiquidTemplate.new(working_directory: base_path)
            else
              template_file = CustomTemplate.new(working_directory: base_path)
              slide.path << template_file.proposed_extname
            end

            slide.template = Erubis::Eruby.new(template_file.content)

            slide
          end
        end

        private

        def template(template_name)
          File.expand_path("../../../../templates/slides/#{template_name}", __FILE__)
        end
      end
    end
  end
end
