require 'middleman-core/cli'

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

      desc "slide ", "Create a new slide"
      def slide(name)
        shared_instance = ::Middleman::Application.server.inst

        # This only exists when the config.rb sets it!
        if shared_instance.extensions.key? :presentation
          presentation_inst = shared_instance.extensions[:presentation]
          slide_template = Presentation::SlideTemplate.new(name: name, base_path: File.join(shared_instance.source_dir, presentation_inst.options.slides_directory))

          template presentation_inst.options.public_send(:"slide_template_#{slide_template.type}"), slide_template.file_path
        else
          raise Thor::Error.new 'You need to activate the presentation extension in config.rb before you can create a slide.'
        end
      end
    end
  end
end
