# encoding: utf-8
module Middleman
  module Presentation
    class IgnoreDuplicates

      private

      attr_reader :unignore, :ignore

      public

      def initialize(ignore_file:)
        @unignore = Regexp.new
        @ignore   = Regexp.new

        File.open(ignore_file, 'r') do |l|
          if l =~ /^!/
            @unignore = @unignore.union Regexp.new(l)
          else
            @unignore = @ignore.union Regexp.new(l)
          end
        end
      end

      def transform(slides)
        slides.keep_if { |s| unignore === s.path && !(ignore === s.path) }
      end
    end
  end
end
