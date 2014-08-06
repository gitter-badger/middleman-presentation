# encoding
module Middleman
  module Presentation
    class ExistingSlide
      include Comparable

      attr_reader :path

      private

      attr_reader :base_path

      public

      def initialize(path, base_path: nil)
        @path      = Pathname.new(path)

        base_path = @path.dirname if base_path.blank?
        @base_path = Pathname.new(base_path)
      end

      def group
        @group ||= extract_group
      end

      def content
        @content ||= File.read(path).chomp
      end

      def file_name
        path.basename
      end

      def exist?
        path.exist?
      end

      # Return file extension
      def extname
        path.extname
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

      # @private
      def <=>(other)
        return false unless path

        path <=> other.path
      end

      # @private
      def eql?(other)
        return false unless path

        path.eql? other.path
      end

      # Is slide similar to another slide
      def similar?(other)
        return true if eql? other

        basename?(other.basename) && group?(other.group)
      end

      # @private
      def hash
        path.hash
      end

      # Checks if slide is in group
      def group?(g)
        group == g
      end

      # Is group?
      def group_object?
        false
      end

      # Render slide
      def render(&block)
        result = []
        result << "<!-- #{relative_path} -->"
        result << block.call(partial_path).to_s

        result.join("\n")
      end

      def relative_path
        path.relative_path_from(base_path)
      end

      def to_s
        path.to_s
      end

      def partial_path
        dirname, base = relative_path.split

        while !base.extname.blank? do 
          base = base.basename('.*')
        end

        dirname + base
      end

      def basename
        base = relative_path.basename

        while !base.extname.blank? do 
          base = base.basename('.*')
        end

        base.to_s
      end

      private

      def basename?(b)
        basename == b
      end

      def extract_group
        group  = relative_path.dirname.basename

        group = if group == relative_path.dirname
                  nil
                else
                  group
                end

        group
      end
    end
  end
end
#
#      # Check type of slide
#      def type?(t)
#        type == t
#      end
#
#      # Determine type of slide
#      def type
#        return :erb    if extname? '.erb'
#        return :md     if extname? '.md', '.markdown', '.mkd'
#        return :liquid if extname? '.l', '.liquid'
#
#        :custom
#      end
#      private :type
#
#      # Check if slide has given extensions
#      def extname?(*extensions)
#        return false if !path && !name
#
#        extensions.any? { |e| extname == e }
#      end
#      private :extname?
#
#      # Return string representation of self
#      def to_s
#        path
#      end
#
#      # Return basename of slide
#      def basename
#        File.basename(name).scan(/^([^.]+)(?:\..+)?/).flatten.first
#      end
#
#      # Check if basename is equal
#      def basename?(b)
#        basename == b
#      end
#      private :basename?
#
#    end
#  end
#end
