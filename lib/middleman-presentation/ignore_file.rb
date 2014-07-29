# encoding: utf-8
module Middleman
  module Presentation
    class IgnoreFile

      private

      attr_reader :unignore, :ignore, :path

      protected

      attr_writer :unignore, :ignore

      public

      def initialize(path)
        @unignore = @ignore = /^!$/
        @path = path

        parse_file(path) if File.exist? path
      end

      def ignore?(slide)
        return false unless File.exist? path

        slide.match?(ignore) && !slide.match?(unignore)
      end

      private

      def parse_file(path)
        File.readlines(path).each do |l|
          next if l =~ /^#/
          l = l.chomp.sub(/\s*#.*/, '')

          if l =~ /^!/
            self.unignore = Regexp.union(
              unignore, 
              Regexp.new(
                l.sub(/^!/, '')
              )
            )
          else
            self.ignore = Regexp.union(ignore, Regexp.new(l))
          end
        end

      end
    end
  end
end
