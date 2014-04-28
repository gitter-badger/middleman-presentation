# encoding: utf-8
module Middleman
  module Presentation
    class PresentationExtension < Extension
      #option :slides_directory, 'slides', 'Pattern for matching source slides'
      #option :slide_template_erb, File.expand_path('../commands/slide.erb.tt', __FILE__), 'Path (relative to project root) to an ERb template that will be used to generate new slide from the "middleman slide" command.'
      #option :slide_template_md, File.expand_path('../commands/slide.md.tt', __FILE__), 'Path (relative to project root) to an markdown template that will be used to generate new slide from the "middleman slide" command.'

      #self.defined_helpers = [ Middleman::Presentation::Helpers ]
      helpers do

        # Yield slides
        def yield_slides
          "hello world"
          #Presentation::Slide.clear
          #Presentation::Slide.create_from(File.join(root, app.options.slides_directory))

          #Presentation::Slide.all.each do |s|
          #  partial s.relative_to_path(root)
          #end
        end
      end
    end
  end
end
