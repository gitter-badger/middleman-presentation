# encoding: utf-8
module Middleman
  module Presentation
    class Slide

      @database = Set.new

      class << self
        private

        attr_accessor :database

        public

        def create(path)
          database << new(path)
        end

        def load_from(directory)
          Dir.glob(File.join(directory, '*')).keep_if { |f| File.file? f }.each do |f|
            create(f)
          end
        end

        def all
          database
        end

        def clear
          self.database = Set.new
        end

        # Count of available slides
        #
        # @return [Integer]
        #   Count of slides
        def count
          database.size
        end
      end

      private

      attr_reader :path

      public

      def initialize(path)
        @path = Pathname.new(path)
      end

      def relative_to_path(base)
        path.relative_path_from(Pathname.new(base)).to_s
      end
    end
  end
end
