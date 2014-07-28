# encoding: utf-8
module Middleman
  module Presentation
    module Transformers
      class TemplateFinder
        def transform(slide)
          slide.template = Erubis::Eruby.new(File.read(template_file)) if slide.respond_to? :template

          slide
        end

        private

        def template(template_name)
          File.expand_path("../../../../templates/slides/#{template_name}", __FILE__ )
        end
      end
    end
  end
end
