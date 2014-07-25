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

      desc 'create NAME(S)', 'Create a new slide(s). If you want to create multiple slides enter them with a space between the names "01 02 03".', hidden: true
      option :title, desc: 'Title of slide'
      def create(*names)
        @title = options[:title]

        shared_instance = ::Middleman::Application.server.inst

        # This only exists when the config.rb sets it!
        if shared_instance.extensions.key? :presentation
          presentation_inst = shared_instance.extensions[:presentation]

          names.each do |name|
            slide_template = ::Middleman::Presentation::SlideTemplate.new(name: name, base_path: File.join(shared_instance.source_dir, presentation_inst.options.slides_directory))
            template presentation_inst.options.public_send(:"slide_template_#{slide_template.type}"), slide_template.file_path
          end
        else
          raise Thor::Error.new 'You need to activate the presentation extension in config.rb before you can create a slide.'
        end
      end

      desc 'slide NAME(S)', 'Create a new slide(s) or edit existing ones. If you want to create multiple slides enter them with a space between the names "01 02 03".'
      option :edit, default: Middleman::Presentation.config.edit, desc: 'Start ENV["EDITOR"] to edit slide.', aliases: %w{-e}
      option :editor_command, default: Middleman::Presentation.config.editor_command, desc: 'editor command to be used, e.g. ENV["EDITOR"] --servername presentation --remote-tab'
      option :title, desc: 'Title of slide'
      def slide(*names)
        shared_instance = ::Middleman::Application.server.inst

        # This only exists when the config.rb sets it!
        if shared_instance.extensions.key? :presentation
          candidates = find_files directory: shared_instance.source_dir, patterns: names
          invoke('slide:create', names - candidates, title: options[:title]) if candidates.size != names.size

          if options[:edit]
            editor = []
            editor << options[:editor_command]
            editor.concat find_files(directory: shared_instance.source_dir, patterns: names)

            system(editor.join(" "))
          end
        else
          raise Thor::Error.new 'You need to activate the presentation extension in config.rb before you can create a slide.'
        end
      end

      no_commands do
        def find_files(directory:, patterns:)
          patterns.inject([]) do |memo, pattern|
            memo << Dir.glob(File.join(directory, 'slides', "#{pattern}*")).first

            memo
          end.compact
        end
      end
    end
  end
end
