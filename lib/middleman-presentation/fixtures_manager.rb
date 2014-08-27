# encoding: utf-8
module Middleman
  module Presentation
    # Fixture manager
    class FixturesManager
      private

      attr_reader :fixtures, :creator, :null_klass

      public

      def initialize(creator: Fixture, null_klass: NoFixture)
        @fixtures   = Set.new
        @creator    = creator
        @null_klass = null_klass
      end

      # Load fixtures found at path
      def load_fixtures(path)
        path = Pathname.new(path)

        path.entries.each do |f|
          next if f.to_s[/^\.\.?/]

          add f.expand_path(path)
        end
      end

      # Add fixture
      def add(path)
        fixtures << creator.new(path)
      end

      # Find fixture
      def find(name)
        fixtures.find(null_klass.new(name)) { |f| f.name == name }
      end

      # String representation
      def to_s
        data = frontend_components.sort.reduce([]) { |a, e| a << { name: e.name, path: e.path } }
        List.new(data).to_s
      end
    end
  end
end
