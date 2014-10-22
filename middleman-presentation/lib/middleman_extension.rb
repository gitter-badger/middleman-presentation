# encoding: utf-8
require 'middleman-presentation'

::Middleman::Extensions.register(:presentation) do
  ::Middleman::Presentation::PresentationExtension
end

require 'pry'

binding.pry
