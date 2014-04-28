require 'set'
require 'pathname'
require 'middleman-core'
require 'middleman-core/cli'

require 'active_support/core_ext/string/strip'
require 'active_support/core_ext/string/inflections'

require 'middleman-presentation/version'
require 'middleman-presentation/slide'
require 'middleman-presentation/slide_template'
require 'middleman-presentation/commands/slide'
require 'middleman-presentation/commands/presentation'

::Middleman::Extensions.register(:presentation) do
  require 'middleman-presentation/extension'
  ::Middleman::PresentationExtension
end
