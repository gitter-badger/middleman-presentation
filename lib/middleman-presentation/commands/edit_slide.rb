# encoding: utf-8
require 'middleman-presentation'

module Middleman
  module Cli
    # This class provides an 'slide' command for the middleman CLI.
    class EditSlide < Thor
      include Thor::Actions

      check_unknown_options!

      namespace :'edit_slide'

      map 'edit-slide' => :edit_slide

      def self.source_root
        ENV['MM_ROOT']
      end

      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
      end

      desc 'edit_slide NAME(S)', 'Edit existing slide(s). The given name can be a substring of the full file name, e.g. 01 instead of 01.html.erb. If you want to edit multiple slides enter them with a space between the names "01 02 03"'
      option :editor_command, default: Middleman::Presentation.config.editor_command, desc: 'editor command to be used, e.g. ENV["EDITOR"] --servername presentation --remote-tab'
      def edit_slide(*names)
        shared_instance = ::Middleman::Application.server.inst

        # This only exists when the config.rb sets it!
        if shared_instance.extensions.key? :presentation
          candidates = find_files directory: shared_instance.source_dir, patterns: names
          invoke('slide:slide', names - candidates) if candidates.size != names.size

          editor = []
          editor << options[:editor_command]
          editor.concat find_files(directory: shared_instance.source_dir, patterns: names)
          editor << '2>/dev/null'

          system(editor.join(" "))
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
