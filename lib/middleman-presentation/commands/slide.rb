# encoding: utf-8
require 'middleman-presentation'

module Middleman
  module Cli
    # This class provides an 'slide' command for the middleman CLI.
    class Slide < Thor
      include Thor::Actions

      check_unknown_options!

      namespace :slide

      def self.source_root
        ENV['MM_ROOT']
      end

      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
      end

      desc 'slide ', 'Create a new slide'
      option :edit, default: Middleman::Presentation.config.edit, desc: 'Start ENV["EDITOR"] to edit slide.', aliases: %w{-e}
      option :editor, default: Middleman::Presentation.config.editor, desc: 'Editor to use, defaults to ENV["EDITOR"]'
      option :editor_parameters, default: Middleman::Presentation.config.editor_parameters, desc: 'Parameters for ENV["EDITOR"], e.g. --remote for vim server'
      option :title, desc: 'Title of slide'
      def slide(name)
        @title = options[:title]

        shared_instance = ::Middleman::Application.server.inst

        # This only exists when the config.rb sets it!
        if shared_instance.extensions.key? :presentation
          presentation_inst = shared_instance.extensions[:presentation]

          slide_template = ::Middleman::Presentation::SlideTemplate.new(name: name, base_path: File.join(shared_instance.source_dir, presentation_inst.options.slides_directory))

          template presentation_inst.options.public_send(:"slide_template_#{slide_template.type}"), slide_template.file_path

          if options[:edit]
            editor = []
            editor << options[:editor]
            editor << options[:editor_parameters] if options[:editor_parameters]
            editor << slide_template.file_path

            system(editor.join(" "))
          end
        else
          raise Thor::Error.new 'You need to activate the presentation extension in config.rb before you can create a slide.'
        end
      end
    end
  end
end
