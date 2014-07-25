# encoding: utf-8
module Middleman
  module Presentation
    module Transformers
      class TemplateFinder
        def transform(slide)
          basename = File.basename(slide.name, '.*')

          if slide.extname == '.erb'
            slide.file_name = "#{basename}.html.erb"
            template_file = template('slide.erb.tt')
          elsif slide.extname == '.md' or slide.extname == '.markdown'
            slide.file_name = "#{basename}.html.md"
            template_file = template('slide.md.tt')
          elsif slide.extname == '.l' or slide.extname == '.liquid'
            slide.file_name = "#{basename}.html.liquid"
            template_file = template('slide.liquid.tt')
          else
            slide.file_name = "#{basename}.html.erb"
            template_file = template('slide.erb.tt')
          end

          slide.template = Erubis::Eruby.new(template_file)

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
