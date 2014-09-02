# Fixes bug in middleman
module Middleman
  # Renderers
  module Renderers
    # Sass
    module Sass
      # Template
      class SassPlusCSSFilenameTemplate < ::Tilt::SassTemplate
        def evaluate(context, _)
          @context ||= context
          @engine = ::Sass::Engine.new(data, sass_options)

          begin
            @engine.render
          rescue ::Sass::SyntaxError => e
            ::Sass::SyntaxError.exception_to_css(e)
          end
        end
      end
    end
  end
end
