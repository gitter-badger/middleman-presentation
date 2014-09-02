# encoding: utf-8
module Middleman
  module Presentation
    # Test plugin
    module Test
      # Simple
      module Simple
        extend PluginApi

        add_assets(
          File.expand_path('../../../../../../vendor/assets', __FILE__)
        )

        add_component(
          name: 'impress.js',
          version: 'latest',
          javascripts: ['js/impress.js']
        )

        add_component(
          FrontendComponent.new(
            name: 'angular',
            version: 'latest',
            javascripts: ['angular.js']
          )
        )

        add_helpers do
          def test_simple_helper1
            'test_simple_helper1'
          end
        end

        add_helpers Middleman::Presentation::Test::Simple::Helpers
      end
    end
  end
end
