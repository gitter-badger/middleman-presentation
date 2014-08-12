# encoding: utf-8

require 'set'
# require 'ptools'
require 'pathname'
require 'fileutils'
require 'middleman-core'
require 'middleman-core/cli'
require 'uri'
require 'addressable/uri'
require 'securerandom'
require 'fedux_org_stdlib/app_config'
require 'fedux_org_stdlib/logging/logger'
require 'fedux_org_stdlib/file_template'
require 'fedux_org_stdlib/core_ext/array'
require 'fedux_org_stdlib/core_ext/hash/options'
require 'fedux_org_stdlib/shell_language_detector'
require 'securerandom'
require 'shellwords'
require 'nokogiri'
require 'rake/file_list'

require 'active_support/core_ext/string/strip'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/object/blank'

require 'middleman-presentation/version'
require 'middleman-presentation/file_extensions'
require 'middleman-presentation/logger'
require 'middleman-presentation/presentation_config'
require 'middleman-presentation/main'

require 'middleman-presentation/cli/reset_thor'
require 'middleman-presentation/cli/init_presentation'
require 'middleman-presentation/cli/init'
require 'middleman-presentation/cli/runner'

require 'middleman-presentation/frontend_component'
require 'middleman-presentation/comparable_slide'
require 'middleman-presentation/existing_slide'
require 'middleman-presentation/new_slide'
require 'middleman-presentation/css_class_extracter'
require 'middleman-presentation/slide_list'
require 'middleman-presentation/helpers'
require 'middleman-presentation/ignore_file'
require 'middleman-presentation/slide_group'
require 'middleman-presentation/commands/config'
require 'middleman-presentation/commands/slide'
require 'middleman-presentation/commands/presentation'
require 'middleman-presentation/commands/theme'
require 'middleman-presentation/commands/style'
require 'middleman-presentation/group_template'
require 'middleman-presentation/erb_template'
require 'middleman-presentation/markdown_template'
require 'middleman-presentation/liquid_template'
require 'middleman-presentation/custom_template'
require 'middleman-presentation/transformers/group_slides'
require 'middleman-presentation/transformers/sort_slides'
require 'middleman-presentation/transformers/ignore_slides'
require 'middleman-presentation/transformers/remove_duplicate_slides'
require 'middleman-presentation/transformers/file_keeper'

::Middleman::Extensions.register(:presentation) do
  require 'middleman-presentation/extension'
  ::Middleman::Presentation::PresentationExtension
end
