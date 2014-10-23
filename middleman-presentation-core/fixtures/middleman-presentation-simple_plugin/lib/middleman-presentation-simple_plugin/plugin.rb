# encoding: utf-8
module Middleman
  module Presentation
    # Simple Plugin
    module SimplePlugin
      extend PluginApi

      add_assets(
        path: File.expand_path('../../../../../../vendor/assets', __FILE__),
        importable_files: ['.*\.scss']
      )

      add_component(
        name: 'angular',
        version: 'latest',
        importable_files: ['.*\.js']
      )

      add_component(
        name: 'impress.js',
        version: 'latest',
        importable_files: ['js/impress\.js']
      )

      add_helpers do
        def test_simple_helper1
          'test_simple_helper1'
        end
      end

      add_helpers Middleman::Presentation::SimplePlugin::Helpers
    end
  end
end
