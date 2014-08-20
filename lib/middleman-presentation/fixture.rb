# encoding: utf-8
module Middleman
  module Presentation
    # Fixture
    class Fixture
      include ComparableByName

      private

      attr_reader :type

      public

      attr_reader :name, :path

      def initialize(path)
        @path = Pathname.new(File.expand_path(path))
      end

      # Name of fixture
      def name
        path.basename.to_s.sub(/-[^-]+$/, '')
      end

      # Is of type?
      #
      # @return [TrueClass,FalseClass]
      #   The result of test
      def type?(t)
        type == t
      end

      private

      def type
        if path.end_with? '-plugin'
          :plugin
        else
          :app
        end
      end
    end
  end
end
