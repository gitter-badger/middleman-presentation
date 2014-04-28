# encoding: utf-8
module Middleman
  module Presentation
    class SlideRepository

      private

      attr_accessor :database

      public

      def initialize(slide_directory = nil)
        @database = Set.new

        load_from slide_directory unless slide_directory.blank?
      rescue KeyError => err
        raise ArgumentError, err.message
      end


      def all
        database.dup
      end

      def clear
        self.database = Set.new
      end

      # Count of available slides
      #
      # @return [Integer]
      #   Count of slides
      def count
        database.dup.size
      end

      def add(path, creator = Slide)
        database << creator.new(path)
      end

      def load_from(directory)
        Dir.glob(File.join(directory, '*')).keep_if { |f| File.file? f }.each do |f|
          add(f)
        end
      end
    end
  end
end
