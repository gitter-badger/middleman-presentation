# encoding: utf-8
module Middleman
  module Presentation
    # Presentation extension
    class MiddlemanExtension < Extension
    end
  end
end

::Middleman::Extensions.register(:presentation) do
  ::Middleman::Presentation::MiddlemanExtension
end
