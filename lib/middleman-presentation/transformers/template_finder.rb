# encoding: utf-8
module Middleman
  module Presentation
    module Transformers
      class TemplateFinder
        def transform(slide)
          if slide.type == :erb
            template_file = template('slide.erb.tt')
          elsif slide.type == :md
            template_file = template('slide.md.tt')
          elsif slide.type == :liquid
            template_file = template('slide.liquid.tt')
          else
            template_file = template('slide.md.tt')
          end

          slide.template = Erubis::Eruby.new(File.read(template_file))

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
