# encoding: utf-8
require 'kramdown'

# External
module Kramdown
  # External
  module Converter
    # External
    module SyntaxHighlighter
      # Middleman Presentation Converter
      module MiddlemanPresentation
        def self.call(converter, text, lang, type, _unused_opts)
          opts = converter.options[:syntax_highlighter_opts].dup
          text = ERB::Util.html_escape(text)

          case type
          when :span
            %(<code class=\"#{opts[:inline_code_class]}\">#{text}</code>)
          when :block
            %(<pre class=\"#{opts[:code_block_class]}\"><code class=\"#{opts[:language_prefix]}#{lang}\">#{text}</code></pre>)
          else
            %(<pre class=\"#{opts[:code_block_class]}\"><code class=\"#{opts[:language_prefix]}#{lang}\">#{text}</code></pre>)
          end
        end
      end
    end
  end
end

module Kramdown
  module Converter
    klass   = ::Kramdown::Converter::SyntaxHighlighter::MiddlemanPresentation
    kn_down = :middleman_presentation

    add_syntax_highlighter(kn_down) do |converter, text, lang, type, opts|
      add_syntax_highlighter(kn_down, klass)
      syntax_highlighter(kn_down).call(converter, text, lang, type, opts)
    end
  end
end
