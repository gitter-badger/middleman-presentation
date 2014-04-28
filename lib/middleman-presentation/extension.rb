# encoding: utf-8
module Middleman
  module Presentation
    class PresentationExtension < Extension
      option :slides_directory, 'slides', 'Pattern for matching source slides'
      option :slide_template_erb, File.expand_path('../commands/slide.erb.tt', __FILE__), 'Path (relative to project root) to an ERb template that will be used to generate new slide from the "middleman slide" command.'
      option :slide_template_md, File.expand_path('../commands/slide.md.tt', __FILE__), 'Path (relative to project root) to an markdown template that will be used to generate new slide from the "middleman slide" command.'

      self.defined_helpers = [ Middleman::Presentation::Helpers ]

      def initialize(app, options_hash={}, &block)
        super

        @app = app
      end

      helpers do
        # Output highlighted code. Use like:
        #
        #    <% code('ruby') do %>
        #      my code
        #    <% end %>
        #
        # To produce the following structure:
        #
        #    <div class="highlight">
        #      <pre>#{your code}
        #      </pre>
        #    </div>
        #
        # @param [String] language the Rouge lexer to use
        # @param [Hash] Options to pass to the Rouge formatter & lexer, overriding global options set by :highlighter_options.
        def code(language=nil, options={}, &block)
          raise 'The code helper requires a block to be provided.' unless block_given?

          # Save current buffer for later
          @_out_buf, _buf_was = "", @_out_buf

          begin
            content = capture_html(&block)
          ensure
            # Reset stored buffer
            @_out_buf = _buf_was
          end
          content = content.encode(Encoding::UTF_8)

          concat_content Middleman::Syntax::Highlighter.highlight(content, language).html_safe
        end
      end

    end
  end
end
