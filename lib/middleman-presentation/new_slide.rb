# encoding: utf-8
module Middleman
  module Presentation
    class NewSlide
      attr_accessor :name, :template, :path, :file_name

      def initialize(name:)
        @name     = name
        @template = Erubis::Eruby.new ''
      end

      def write(**data)
        File.write(content(**data), path)
      end

      def content(**data)
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
    end
  end
end
