# encoding: utf-8
require 'kramdown'

module Kramdown
  module Converter
    module SyntaxHighlighter
      # Plain converter
      module MiddlemanPresentation
        def self.call(_converter, text, _lang, _type, _unused_opts)
          #text
        end
      end
    end
  end
end

require 'pry'
binding.pry

module Kramdown
  module Converter
    klass_name = MiddlemanPresentation
    kn_down    = klass_name.underscore

    add_syntax_highlighter(kn_down) do |converter, text, lang, type, opts|
      add_syntax_highlighter(kn_down, klass)
      syntax_highlighter(kn_down).call(converter, text, lang, type, opts)
    end
  end
end
