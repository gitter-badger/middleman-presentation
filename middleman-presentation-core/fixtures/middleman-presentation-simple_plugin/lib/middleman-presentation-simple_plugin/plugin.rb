# encoding: utf-8
module Middleman
  module Presentation
    # Simple Plugin
    module SimplePlugin
      extend PluginApi

      add_assets(
        File.expand_path('../../../../../../vendor/assets', __FILE__)
      )

      add_component(
        name: 'angular.js',
        version: 'latest',
        importable_files: ['js/angular.js']
      )

      add_component(
        name: 'impress.js',
        version: 'latest',
        importable_files: ['js/impress.js']
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
