# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Run command
      class Runner < Base
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
      end
    end
  end
end
