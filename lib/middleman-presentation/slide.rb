# encoding: utf-8
module Middleman
  module Presentation
    class Slide
      include Comparable

      attr_accessor :name, :template, :path, :file_name, :content, :type, :partial_path

      def initialize(name:)
        @name     = name
        @template = Erubis::Eruby.new ''
      end

      def write(**data)
        File.write(content(**data), path)
      end

      def content(**data)
        #return @content unless @content.blank?

        template.result(data)
      end

      def exist?
        return false unless path

        File.exist? path
      end

      def extname
        File.extname(name)
      end

      def to_s
        path
      end

      def basename
        File.basename(name).scan(/^([^.]+)(?:\..+)?/).flatten.first
      end

      def <=>(other)
        file_name <=> other.file_name
      end

      def eql?(other)
        file_name.eql? other.file_name
      end

      def similar?(other)
        basename == other.basename
      end

      def hash
        file_name.hash
      end
    end
  end
end
