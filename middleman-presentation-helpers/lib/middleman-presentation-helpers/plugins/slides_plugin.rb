# encoding: utf-8
module Middleman
  module Presentation
    # Helpers plugin
    module Helpers
      # Slides plugin
      module SlidesPlugin
        extend PluginApi

        output_paths = {
          %r{plugin/notes/notes\.html$} => Pathname.new('javascripts/reveal.js/plugin/notes/notes.html'),
          /pdf\.css$/ => Pathname.new('stylesheets/reveal.js/css/print/pdf.css')
        }

        loadable_files = [
          %r{plugin/notes/notes\.html$},
          /pdf\.css$/,
          %r{reveal\.js/.*/.*\.js$}
        ]

        add_component(
          name: :'reveal.js',
          version: 'latest',
          importable_files: %w(js/reveal.min.js lib/js/head.min css/reveal.min.css lib/css/zenburn css/theme/template/mixins.scss css/theme/template/settings.scss),
          ignorable_files: %w(reveal\.js/test/),
          output_paths: output_paths,
          loadable_files: loadable_files
        )

        add_helpers Middleman::Presentation::Helpers::Slides
      end
    end
  end
end
