# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'presentation init' command for the middleman CLI.
      class Init < Thor
        include Thor::Actions

        desc 'application ', 'Initialize system for use of middleman-presentation'
        option :configuration_file, default: Middleman::Presentation.config.preferred_configuration_file, desc: 'Path to configuration file'
        option :force, type: :boolean, desc: 'Force creation of config file'
        def application
          source_paths << File.expand_path('../../../../templates', __FILE__)

          @version = Middleman::Presentation::VERSION
          @config = Middleman::Presentation.config

          opts = options.dup.deep_symbolize_keys
          template 'config.yaml.tt', opts.delete(:configuration_file), **opts
        end
      end
    end
  end
end
