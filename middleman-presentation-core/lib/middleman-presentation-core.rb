# encoding: utf-8
require 'middleman-core'
require 'middleman-core/cli'
require 'middleman-sprockets'

require 'set'
require 'bundler'
require 'English'
# require 'ptools'
require 'pathname'
require 'fileutils'
require 'uri'
require 'addressable/uri'
require 'securerandom'
require 'launchy'
require 'colorize'
require 'fedux_org_stdlib/app_config'
require 'fedux_org_stdlib/logging/logger'
require 'fedux_org_stdlib/file_template'
require 'fedux_org_stdlib/template_directory'
require 'fedux_org_stdlib/list'
require 'fedux_org_stdlib/core_ext/array/list'
require 'fedux_org_stdlib/core_ext/hash/list'
require 'fedux_org_stdlib/core_ext/hash/options'
require 'fedux_org_stdlib/core_ext/string/characterize'
require 'fedux_org_stdlib/roles/comparable_by_name'
require 'fedux_org_stdlib/roles/typable'
require 'fedux_org_stdlib/core_ext/string/underline'
require 'fedux_org_stdlib/recursive_file_finder'
require 'fedux_org_stdlib/shell_language_detector'
require 'fedux_org_stdlib/support_information'
require 'fedux_org_stdlib/gem_plugins'
require 'fedux_org_stdlib/editor'
require 'securerandom'
require 'shellwords'
require 'nokogiri'
require 'rake/file_list'
require 'zip'

require 'active_support/core_ext/string/strip'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/kernel/reporting'

require 'middleman-presentation-core/errors'
require 'middleman-presentation-core/configuration_file'
require 'middleman-presentation-core/middleman_environment'
require 'middleman-presentation-core/overwrite_sass'
require 'middleman-presentation-core/plugin'
require 'middleman-presentation-core/version'
require 'middleman-presentation-core/ruby'
require 'middleman-presentation-core/syntax_highlighter'
require 'middleman-presentation-core/list'
require 'middleman-presentation-core/asset_store'
require 'middleman-presentation-core/plugin_api'
require 'middleman-presentation-core/logger'
require 'middleman-presentation-core/application_config'
require 'middleman-presentation-core/asset_list'
require 'middleman-presentation-core/cache'
require 'middleman-presentation-core/asset'
require 'middleman-presentation-core/presentation_helper'
require 'middleman-presentation-core/locale_configurator'
require 'middleman-presentation-core/component'
require 'middleman-presentation-core/frontend_component'
require 'middleman-presentation-core/asset_component'
require 'middleman-presentation-core/plugins_manager'
require 'middleman-presentation-core/assets_manager'
require 'middleman-presentation-core/helpers_manager'
require 'middleman-presentation-core/components_manager'
require 'middleman-presentation-core/assets_loader'

# This loads a lot
require 'middleman-presentation-core/main'

Middleman::Presentation.enable_debug_mode if ENV.key? 'DEBUG'

require 'middleman-presentation-core/predefined_slide_templates_directory'
require 'middleman-presentation-core/comparable_slide'
require 'middleman-presentation-core/existing_slide'
require 'middleman-presentation-core/new_slide'
require 'middleman-presentation-core/css_class_extracter'
require 'middleman-presentation-core/slide_name'
require 'middleman-presentation-core/slide_list'
require 'middleman-presentation-core/ignore_file'
require 'middleman-presentation-core/slide_group'
require 'middleman-presentation-core/build_readme_template'
require 'middleman-presentation-core/presentation_license_template'
require 'middleman-presentation-core/group_template'
require 'middleman-presentation-core/erb_template'
require 'middleman-presentation-core/markdown_template'
require 'middleman-presentation-core/liquid_template'
require 'middleman-presentation-core/custom_template'

require 'middleman-presentation-core/transformers/group_slides'
require 'middleman-presentation-core/transformers/sort_slides'
require 'middleman-presentation-core/transformers/ignore_slides'
require 'middleman-presentation-core/transformers/remove_duplicate_slides'
require 'middleman-presentation-core/transformers/file_keeper'

require 'middleman-presentation-core/cli/shared'
require 'middleman-presentation-core/cli/base'
require 'middleman-presentation-core/cli/base_group'
require 'middleman-presentation-core/cli/reset_thor'
require 'middleman-presentation-core/cli/create_theme'
require 'middleman-presentation-core/cli/create_slide'
require 'middleman-presentation-core/cli/create_plugin'
require 'middleman-presentation-core/cli/create_presentation'
require 'middleman-presentation-core/cli/create'
require 'middleman-presentation-core/cli/change_slide'
require 'middleman-presentation-core/cli/change'
require 'middleman-presentation-core/cli/edit_slide'
require 'middleman-presentation-core/cli/edit'
require 'middleman-presentation-core/cli/serve_presentation'
require 'middleman-presentation-core/cli/build_presentation'
require 'middleman-presentation-core/cli/build'
require 'middleman-presentation-core/cli/export_presentation'
require 'middleman-presentation-core/cli/export'
require 'middleman-presentation-core/cli/show'
require 'middleman-presentation-core/cli/serve'
require 'middleman-presentation-core/cli/list'
require 'middleman-presentation-core/cli/init_application'
require 'middleman-presentation-core/cli/init_predefined_slides'
require 'middleman-presentation-core/cli/init'
require 'middleman-presentation-core/cli/runner'

require 'middleman-presentation-core/utils'

require 'middleman-presentation-core/middleman_extension'
require 'middleman-presentation-core/register_extension'

require 'middleman-presentation-core/start'
