# encoding: utf-8
module Middleman
  module Presentation
    class IgnoreDuplicates

      private

      attr_reader :unignore, :ignore

      public

      def initialize(ignore_file:)
        @unignore = []
        @ignore   = []

        File.open(ignore_file, 'r') do |l|
          if l =~ /^!/
            @unignore << Regexp.new(l)
          else
            @ignore   << Regexp.new(l)
          end
        end
      end

      def transform(slides)
      end
    end
  end
end
