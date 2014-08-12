# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Run command
      class Runner < Thor
        desc 'init', 'Initialize system, presentation, ...'
        subcommand 'init', Init

        desc 'show', 'Show information ...'
        subcommand 'show', Show

        desc 'create', 'Create something...'
        subcommand 'create', Create
      end
    end
  end
end
