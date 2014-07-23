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

      desc 'edit_slide NAME', 'Edit existing slide. The given name can be a substring of the full file name, e.g. 01 instead of 01.html.erb'
      option :editor_command, default: Middleman::Presentation.config.editor_command, desc: 'editor command to be used, e.g. ENV["EDITOR"] --servername presentation --remote-tab'
      def edit_slide(name)
        shared_instance = ::Middleman::Application.server.inst

        # This only exists when the config.rb sets it!
        if shared_instance.extensions.key? :presentation
          candidate = Dir.glob(File.join(shared_instance.source_dir, 'slides', "#{name}*")).first

          if candidate.blank?
            invoke 'slide:slide', [name], edit: true, **options.deep_symbolize_keys
          else
            editor = []
            editor << options[:editor_command]
            editor << candidate
            editor << '2>/dev/null'

            system(editor.join(" "))
          end
        else
          raise Thor::Error.new 'You need to activate the presentation extension in config.rb before you can create a slide.'
        end
      end
    end
  end
end
