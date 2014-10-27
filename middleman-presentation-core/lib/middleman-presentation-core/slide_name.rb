# encoding: utf-8
module Middleman
  module Presentation
    class SlideName
      private

      attr_reader :old_slide, :base_name, :type

      public

      def initialize(old_slide, base_name:, type:)
        @old_slide = old_slide
        @base_name = base_name
        @type = type
      end

      def to_s
        return get_base_name + guess_type if !(base_name && type)

        get_base_name + get_type
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

      def get_base_name
        return base_name if base_name

        old_slide.base_name
      end

      def get_type
        return type.gsub(/^\./, '').prepend('.') if type

        File.extname(old_slide.ext_name)
      end
    end
  end
end
