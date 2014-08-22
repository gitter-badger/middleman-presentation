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
      end
    end
  end
end
