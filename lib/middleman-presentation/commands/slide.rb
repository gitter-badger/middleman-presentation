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
        if shared_instance.respond_to? :presentation
          require 'pry'
          binding.pry

          presentation_inst = shared_instance.presentation
          template presentation_inst.options.new_slide_template, File.join(shared_instance.source_dir, name + presentation_inst.options.default_extension)
        else
          raise Thor::Error.new "You need to activate the blog extension in config.rb before you can create an article"
        end
      end
    end
  end
end
