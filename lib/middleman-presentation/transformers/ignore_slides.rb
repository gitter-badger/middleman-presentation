# encoding: utf-8
module Middleman
  module Presentation
    class IgnoreDuplicates

      private

      attr_reader :consider, :ignore

      public

      def initialize(ignore_file:)
        @consider = []
        @ignore   = []

        File.open(ignore_file, 'r') do |l|
          if l =~ /^!/
            @consider << Regexp.new(l)
          else
            @allowed  << Regexp.new(l)
          end
        end
      end

      def transform(slides)
      end
    end
  end
end
