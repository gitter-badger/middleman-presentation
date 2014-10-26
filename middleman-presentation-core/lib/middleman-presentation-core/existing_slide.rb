# encoding
module Middleman
  module Presentation
    # Used for slides which already exist in file system
    class ExistingSlide
      include ComparableSlide

      attr_reader :path

      private

      attr_reader :base_path

      public

      # Create Existin slide object
      def initialize(path, base_path: nil)
        @path      = Pathname.new(path)

        base_path = @path.dirname if base_path.blank?
        @base_path = Pathname.new(base_path)
      end

      # Relative path inside source directory
      def relative_path
        path.relative_path_from(base_path)
      end

      # Group of slide
      def group
        @group ||= extract_group
      end

      # Filename of slide, e.g 01.html.erb
      def file_name
        path.basename
      end

      # Does slide really exist in filesystem
      def exist?
        path.exist?
      end

      # Render slide
      def render(&block)
        result = []
        result << "<!-- #{relative_path} -->"
        result << block.call(path).to_s

        result.join("\n")
      end

      # String representation of slide
      def to_s
        path.to_s
      end

      # Return partial path of existing slide
      def partial_path
        dirname, base = relative_path.split

        base = base.basename('.*') until base.extname.blank?

        dirname + base
      end

      # Return base name for slide
      def base_name
        base = relative_path.basename

        base = base.basename('.*') until base.extname.blank?

        base.to_s
      end

      # Return ext name for slide
      def ext_name
        file_name.to_s.gsub(/^([^.]+)\./, '.')
      end

      private

      def extract_group
        group  = relative_path.dirname.basename

        return nil if group == relative_path.dirname

        group.to_s
      end
    end
  end
end
