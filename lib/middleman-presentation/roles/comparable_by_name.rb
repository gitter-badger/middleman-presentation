# encoding: utf-8
module Middleman
  module Presentation
    module ComparableByName
      include Comparable

      # @private
      def hash
        name.hash
      end

      # @private
      def eql?(other)
        name.eql? other.name
      end

      # @private
      def <=>(other)
        name <=> other.name
      end
    end
  end
end
