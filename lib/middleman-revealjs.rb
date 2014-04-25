require 'set'
require 'pathname'

require 'middleman-core'
require 'middleman-revealjs/version'

::Middleman::Extensions.register(:revealjs) do
  require 'middleman-revealjs/extension'
  ::Middleman::RevealjsExtension
end
