# encoding: utf-8
require 'middleman-presentation-helpers/slides'

module Middleman
  module Presentation
    # Helpers plugin
    module Helpers
      # Slides plugin
      module SlidesPlugin
        extend PluginApi

        output_directories = {
          /notes\.html$/ => Pathname.new('javascripts'),
          /pdf\.css$/ => Pathname.new('stylesheets')
        }

        loadable_files = [
          /notes\.html/,
          %r{reveal\.js/.*/.*\.js$},
        ]

        add_component(
          name: 'reveal.js',
          version: 'latest',
          importable_files: %w(lib/js/head.min js/reveal.min.js css/reveal.min.css lib/css/zenburn css/theme/template/mixins.scss css/theme/template/settings.scss),
          ignorable_files: %w(test),
          output_directories: output_directories,
          loadable_files: loadable_files
        )

        add_helpers Middleman::Presentation::Helpers::Slides
      end
    end
  end
end