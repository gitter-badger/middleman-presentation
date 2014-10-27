# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Run command
      class Runner < Base
        class_option :debug_mode, default: Middleman::Presentation.config.debug_mode, type: :boolean, desc: Middleman::Presentation.t('views.application.options.debug_mode')

        map '-v' => :version
        map '--version' => :version

        desc 'init', Middleman::Presentation.t('views.runners.init.title')
        subcommand 'init', Init

        desc 'show', Middleman::Presentation.t('views.runners.show.title')
        subcommand 'show', Show

        desc 'create', Middleman::Presentation.t('views.runners.create.title')
        subcommand 'create', Create

        desc 'list', Middleman::Presentation.t('views.runners.list.title')
        subcommand 'list', List

        desc 'export', Middleman::Presentation.t('views.runners.export.title')
        subcommand 'export', Export

        desc 'build', Middleman::Presentation.t('views.runners.build.title')
        subcommand 'build', Build

        desc 'serve', Middleman::Presentation.t('views.runners.build.title')
        subcommand 'serve', Serve

        desc 'change', Middleman::Presentation.t('views.runners.change.title')
        subcommand 'change', Change

        desc 'edit', Middleman::Presentation.t('views.runners.edit.title')
        subcommand 'edit', Edit

        desc 'version', 'version', hide: true
        def version
          invoke 'middleman:presentation:cli:show:version'
        end
      end
    end
  end
end
