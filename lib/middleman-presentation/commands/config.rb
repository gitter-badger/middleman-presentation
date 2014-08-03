# encoding: utf-8
require 'middleman-presentation'

module Middleman
  module Cli
    # This class provides an 'slide' command for the middleman CLI.
    class Config < Thor
      include Thor::Actions

      check_unknown_options!

      namespace :config

      def self.source_root
        ENV['MM_ROOT']
      end

      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
      end

      desc 'config', 'Show configuration'
      def config
        shared_instance = ::Middleman::Application.server.inst

        # This only exists when the config.rb sets it!
        if shared_instance.extensions.key? :presentation
          puts Middleman::Presentation.config.to_s
        else
          raise Thor::Error.new 'You need to activate the presentation extension in config.rb before you can create a slide.'
        end
      end
    end
  end
end
