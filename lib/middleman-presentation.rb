require 'set'
require 'pathname'
require 'middleman-core'

require 'middleman-presentation/version'
require 'middleman-presentation/slide'
require 'middleman-presentation/slide_template'
require 'middleman-presentation/commands/slide'

::Middleman::Extensions.register(:presentation) do
  require 'middleman-presentation/extension'
  ::Middleman::PresentationExtension
end
