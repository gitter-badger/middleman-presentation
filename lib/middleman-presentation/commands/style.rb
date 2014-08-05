# encoding: utf-8
module Middleman
  module Cli
    # This class provides an 'slide' command for the middleman CLI.
    class Style < Thor
      include Thor::Actions

      namespace :style

      def self.source_root
        ENV['MM_ROOT']
      end

      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
      end

      desc 'style', 'Show available styles'
      def style
        css_classes = Middleman::Presentation::CssClassExtracter.new.extract Middleman::Presentation.stylable_files, ignore: %w(slides reveal)

        puts "Available css classes in templates used by middleman-presentation:\n"
        css_classes.each { |klass| puts format '  %20s: %s', klass.name, klass.files.to_list }
        puts
      end
    end
  end
end
