# encoding: utf-8
module Middleman
  module Presentation
    module Transformers
      class TemplateFinder

        private

        attr_reader :base_path

        public

        def initialize(base_path)
          @base_path = base_path
        end

        def transform(slides)
          slides.map do |slide|
            template_file = case slide.type 
                            when :erb
                              ErbTemplate.new(working_directory: base_path)
                            when :md
                              MarkdownTemplate.new(working_directory: base_path)
                            when :liquid
                              LiquidTemplate.new(working_directory: base_path)
                            else
                              MarkdownTemplate.new(working_directory: base_path)
                            end

            slide.template = Erubis::Eruby.new(template_file.content)

            slide
          end
        end

        private

        def template(template_name)
          File.expand_path("../../../../templates/slides/#{template_name}", __FILE__ )
        end
      end
    end
  end
end
