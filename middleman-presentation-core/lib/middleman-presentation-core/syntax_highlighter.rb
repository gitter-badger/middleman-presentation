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

          if lang.to_s.start_with? 'mermaid-'
            %(<div class=\"mermaid #{opts[:code_block_class]}\">#{text}</div>)
          elsif type == :span
            text = ERB::Util.html_escape(text)
            %(<code class=\"#{opts[:inline_code_class]}\">#{text}</code>)
          elsif type == :block
            text = ERB::Util.html_escape(text)
            %(<pre class=\"#{opts[:code_block_class]}\"><code class=\"#{opts[:language_prefix]}#{lang}\">#{text}</code></pre>)
          else
            text = ERB::Util.html_escape(text)
            %(<pre class=\"#{opts[:code_block_class]}\"><code class=\"#{opts[:language_prefix]}#{lang}\">#{text}</code></pre>)
          end
        end
      end
    end
  end
end

# External
module Kramdown
  # External
  module Converter
    klass   = ::Kramdown::Converter::SyntaxHighlighter::MiddlemanPresentation
    kn_down = :middleman_presentation

    add_syntax_highlighter(kn_down) do |converter, text, lang, type, opts|
      add_syntax_highlighter(kn_down, klass)
      syntax_highlighter(kn_down).call(converter, text, lang, type, opts)
    end
  end
end
