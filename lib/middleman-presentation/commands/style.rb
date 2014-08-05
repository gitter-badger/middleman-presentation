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
        paths  = ['../../../../templates/**/*.'].product(%w{html erb md liquid}).product(['.tt']).map(&:join).map { |f| File.expand_path(f, __FILE__) }
        paths.concat ['../../../../templates/slides/'].product(%w{group liquid markdown erb}).product(['.tt']).map(&:join).map { |f| File.expand_path(f, __FILE__) }
        paths.concat ['../../../../templates/'].product(%w{ source/layout.erb source/index.html.erb }).map(&:join).map { |f| File.expand_path(f, __FILE__) }

        list = Rake::FileList.new(paths)

        css_classes = list.each_with_object(Set.new) do |f, a|
          page = Nokogiri::HTML(open(f))
          page.traverse { |n| a << n['class'] if n['class'] }
        end

        puts "Available css classes in templates used by middleman-presentation:"
        puts

        remove_klasses = %w{slides reveal}

        css_classes.to_a.uniq.delete_if { |k| remove_klasses.include? k }.each do |k|
          puts format "  %s", k 
        end

        puts
      end
    end
  end
end
