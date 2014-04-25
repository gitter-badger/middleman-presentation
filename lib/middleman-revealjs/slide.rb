# encoding: utf-8
module Middleman
  module Revealjs
    class Slide
      @database = Set.new

      class << self
        private

        attr_reader :database

        public

        def create(path)
          database << new(path)
        end
      end
    end
  end
end
