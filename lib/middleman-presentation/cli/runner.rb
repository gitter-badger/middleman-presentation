# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      class Runner < Thor
        desc 'init', 'Initialize system, presentation, ...'
        subcommand 'init', Init
      end
    end
  end
end
