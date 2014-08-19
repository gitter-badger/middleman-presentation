# encoding: utf-8
module Middleman
  module Presentation
    # Fixture manager
    class FixturesManager

      private

      include Tablelize

      attr_reader :fixtures, :creator, :null_klass

      public

      def initialize(creator: Fixture, null_klass: NoFixture)
        @fixtures   = Set.new
        @creator    = creator
        @null_klass = null_klass
      end

      def load_fixtures(path)
        path = Pathname.new(path)

        path.entries.each do |f| 
          next if f.to_s[/^\.\.?/]

          add f.expand_path(path)
        end
      end
      
      def add(path)
        fixtures << creator.new(path)
      end

      def find(name)
        fixtures.find(null_klass.new(name)) { |f| f.name == name }
      end

      def to_s
        table frontend_components.inject([]) { |a, e| a << Hash.new(name: e.name, path: e.path) }
      end
    end
  end
end
