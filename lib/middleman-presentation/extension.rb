# encoding: utf-8
module Middleman
  class PresentationExtension < Extension

    #self.defined_helpers = [ Middleman::Blog::Helpers ]

    option :slides_directory, 'slides', 'Pattern for matching source slides'
    option :layout, 'layout', 'Presentation layout'
    option :slide_template_erb, File.expand_path('../commands/slide.erb.tt', __FILE__), 'Path (relative to project root) to an ERb template that will be used to generate new slide from the "middleman slide" command.'
    option :slide_template_md, File.expand_path('../commands/slide.md.tt', __FILE__), 'Path (relative to project root) to an markdown template that will be used to generate new slide from the "middleman slide" command.'
    option :default_extension, '.html.erb', 'Default template extension for slides (used by "middleman slide")'

    def initialize(app, options_hash={}, &block)
      super
    end

    helpers do
      def yield_slides
        Slides.clear
        Slides.create_from(File.join(root, options.sources))

        Slides.all.each do |s|
          partial s.relative_to_path(root)
        end
      end
    end
  end

end
