# encoding: utf-8
module Middleman
  module Presentation
    # Test plugin
    module Test
      # Simple
      module Simple

        require 'pry'
        binding.pry
        PluginApi.add_assets(
          File.expand_path('../../../../../../vendor/assets/components', __FILE__)
        )

        PluginApi.add_component(
          name: 'jquery',
          version: '~1.11',
          javascripts: %w(dist/jquery)
        )

        PluginApi.add_component(
          FrontendComponent.new(
            name: 'reveal.js',
            version: 'latest',
            javascripts: %w(lib/js/head.min js/reveal.min)
          )
        )

        PluginApi.add_helpers do
          def test1_helper
            'test1_helper'
          end
        end

        PluginApi.add_helpers Middleman::Presentation::Test::Simple::Helpers
      end
    end
  end
end
