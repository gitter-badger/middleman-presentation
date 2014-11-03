# encoding: utf-8
require 'kramdown'

module Kramdown
  module Converter
    module SyntaxHighlighter
      # Middleman Presentation Converter
      module MiddlemanPresentation
        def self.call(converter, text, lang, _type, _unused_opts)
          opts = converter.options[:syntax_highlighter_opts].dup

          %{<pre class=\"#{opts[:pre_block_class]}\"><code class=\"#{lang}\">#{ERB::Util.html_escape(text)}</code></pre>}
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
