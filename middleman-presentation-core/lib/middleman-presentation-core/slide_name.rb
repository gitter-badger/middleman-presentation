# encoding: utf-8
module Middleman
  module Presentation
    # Determine slide name base on old slide
    class SlideName
      private

      attr_reader :old_slide, :base_name, :type

      public

      # Create new instance
      #
      # @param [ExistingSlide] old_slide
      #   The old slide which should be used
      #
      # @param [String] base_name
      #   The requested new base of the file name
      #
      # @param [String] type
      #   The requested new type for the slide name
      def initialize(old_slide, base_name:, type:)
        @old_slide = old_slide
        @base_name = base_name
        @type      = type
      end

      # Return the string version of slide name
      def to_s
        return determine_base_name + guess_type if base_name.blank? && type.blank?

        determine_base_name + get_type
      end

      private

      def guess_type
        case File.extname(old_slide.ext_name)
        when '.md'
          '.erb'
        when '.erb'
          '.md'
        else
          '.md'
        end
      end

      def determine_base_name
        return base_name if base_name

        old_slide.base_name
      end

      def determine_type
        return type.gsub(/^\./, '').prepend('.') if type

        File.extname(old_slide.ext_name)
      end
    end
  end
end
