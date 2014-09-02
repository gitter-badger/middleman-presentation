# encoding: utf-8
require 'middleman-presentation/helpers/slides'

module Middleman
  module Presentation
    # Helpers plugin
    module Helpers
      module SlidesPlugin
        extend PluginApi

        add_component(
          name: 'reveal.js',
          version: 'latest',
          javascripts: %w(lib/js/head.min js/reveal.min),
          stylesheets: %w(css/reveal.min lib/css/zenburn css/theme/template/mixins css/theme/template/settings)
        )

        require 'pry'
        binding.pry

        add_helpers Middleman::Presentation::Helpers::Slides
      end
    end
  end
end
