# encoding: utf-8
require 'set'
require 'bundler'
require 'English'
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
require 'fedux_org_stdlib/template_directory'
require 'fedux_org_stdlib/list'
require 'fedux_org_stdlib/core_ext/array/list'
require 'fedux_org_stdlib/core_ext/hash/list'
require 'fedux_org_stdlib/core_ext/hash/options'
require 'fedux_org_stdlib/shell_language_detector'
require 'fedux_org_stdlib/support_information'
require 'fedux_org_stdlib/gem_plugins'
require 'securerandom'
require 'shellwords'
require 'nokogiri'
require 'rake/file_list'

require 'active_support/core_ext/string/strip'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/kernel/reporting'

require 'middleman-presentation/errors'

require 'middleman-presentation/roles/comparable_by_name'

require 'middleman-presentation/version'
require 'middleman-presentation/list'
require 'middleman-presentation/plugin_api'
require 'middleman-presentation/file_extensions'
require 'middleman-presentation/logger'
require 'middleman-presentation/presentation_config'
require 'middleman-presentation/asset'
require 'middleman-presentation/fixture'
require 'middleman-presentation/helpers/slides'
require 'middleman-presentation/presentation_helper'
require 'middleman-presentation/no_fixture'
require 'middleman-presentation/locale_configurator'
require 'middleman-presentation/frontend_component'
require 'middleman-presentation/plugins_manager'
require 'middleman-presentation/assets_manager'
require 'middleman-presentation/fixtures_manager'
require 'middleman-presentation/helpers_manager'
require 'middleman-presentation/frontend_components_manager'
require 'middleman-presentation/default_loader'

# This loads a lot
require 'middleman-presentation/main'

require 'middleman-presentation/predefined_slide_templates_directory'
require 'middleman-presentation/comparable_slide'
require 'middleman-presentation/existing_slide'
require 'middleman-presentation/new_slide'
require 'middleman-presentation/css_class_extracter'
require 'middleman-presentation/slide_list'
require 'middleman-presentation/ignore_file'
require 'middleman-presentation/slide_group'
require 'middleman-presentation/commands/slide'
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

require 'middleman-presentation/cli/base'
require 'middleman-presentation/cli/base_group'
require 'middleman-presentation/cli/reset_thor'
require 'middleman-presentation/cli/create_theme'
require 'middleman-presentation/cli/create_presentation'
require 'middleman-presentation/cli/show'
require 'middleman-presentation/cli/list'
require 'middleman-presentation/cli/init'
require 'middleman-presentation/cli/create'
require 'middleman-presentation/cli/runner'

require 'middleman-presentation/test_helpers'


# This one is an external gem now
require 'middleman-presentation/helpers'

::Middleman::Extensions.register(:presentation) do
  require 'middleman-presentation/extension'
  ::Middleman::Presentation::PresentationExtension
end
