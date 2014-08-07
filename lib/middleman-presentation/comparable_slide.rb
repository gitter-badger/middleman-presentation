# encoding: utf-8
module Middleman
  module Presentation
    module ComparableSlide
      include Comparable

      # Needs to be implemented to make the other methods work
      def path
        raise MethodNotImplemented
      end

      # Needs to be implemented to make the other methods work
      def base_name
        raise MethodNotImplemented
      end

      # Needs to be implemented to make the other methods work
      def group
        raise MethodNotImplemented
      end

      # @private
      def <=>(other)
        path <=> other.path
      end

      # @private
      def eql?(other)
        path.eql? other.path
      end

      # Is slide similar to another slide
      def similar?(other)
        return true if eql? other

        base_name?(other.base_name) && group?(other.group)
      end

      # @private
      def hash
        path.hash
      end

      # Checks if slide is in group
      def group?(g)
        group == g
      end

      # Check if string/regex matches path
      def match?(string_or_regex)
        regex = if string_or_regex.is_a? String
                  Regexp.new(string_or_regex)
                else
                  string_or_regex
                end

        # rubocop:disable Style/CaseEquality:
        regex === relative_path.to_s
        # rubocop:enable Style/CaseEquality:
      end

      # Check if basename is equal
      def base_name?(b)
        base_name == b
      end
    end
  end
end
