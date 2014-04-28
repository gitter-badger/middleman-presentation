# encoding: utf-8
module Middleman
  class PresentationExtension < Extension
    self.defined_helpers = [ Middleman::Presentation::Helpers ]

    option :slides_directory, 'slides', 'Pattern for matching source slides'
    option :slide_template_erb, File.expand_path('../commands/slide.erb.tt', __FILE__), 'Path (relative to project root) to an ERb template that will be used to generate new slide from the "middleman slide" command.'
    option :slide_template_md, File.expand_path('../commands/slide.md.tt', __FILE__), 'Path (relative to project root) to an markdown template that will be used to generate new slide from the "middleman slide" command.'

    def initialize(app, options_hash={}, &block)
      super

      @app = app
    end
  end

end
