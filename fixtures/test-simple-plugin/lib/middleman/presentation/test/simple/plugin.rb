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
        )

        add_component(
          FrontendComponent.new(
            name: 'angular',
            version: 'latest',
          )
        )

        add_helpers do
          def test1_helper
            'test1_helper'
          end
        end

        add_helpers Middleman::Presentation::Test::Simple::Helpers
      end
    end
  end
end
