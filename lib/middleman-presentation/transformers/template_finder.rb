# encoding: utf-8
module Middleman
  module Presentation
    module Transformers
      class TemplateFinder
        def transform(slides)
          slides.map do |slide|
            template_file = case slide.type 
                            when :erb
                              template('slide.erb.tt')
                            when :md
                              template('slide.md.tt')
                            when :liquid
                              template('slide.liquid.tt')
                            else
                              template('slide.md.tt')
                            end

            slide.template = Erubis::Eruby.new(File.read(template_file))

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
