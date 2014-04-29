# encoding: utf-8
module Middleman
  module Presentation
    class PresentationExtension < Extension
      option :slides_directory, 'slides', 'Pattern for matching source slides'
      option :slide_template_erb, File.expand_path('../commands/slide.erb.tt', __FILE__), 'Path (relative to project root) to an ERb template that will be used to generate new slide from the "middleman slide" command.'
      option :slide_template_md, File.expand_path('../commands/slide.md.tt', __FILE__), 'Path (relative to project root) to an markdown template that will be used to generate new slide from the "middleman slide" command.'

      helpers do
        # Yield slides
        def yield_slides
          repo = Presentation::SlideRepository.new(File.join(source_dir, extensions[:presentation].options.slides_directory))

          repo.all.sort.collect do |s|
            partial s.relative_as_partial(source_dir)
          end.join("\n")
        end
      end
    end
  end
end
