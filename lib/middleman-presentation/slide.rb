# encoding: utf-8
module Middleman
  module Presentation
    class Slide
      include Comparable

      attr_accessor :name, :template, :path, :file_name, :type, :partial_path
      attr_writer :content

      def initialize(name:)
        @name     = name
        @template = Erubis::Eruby.new ''
      end

      def write(**data)
        File.open(path, 'wb') do |f|
          f.write(content(**data))
        end
      end

      def content(**data)
        return @content unless @content.blank?

        template.result(data)
      end

      def exist?
        return false unless path

        File.exist? path
      end

      def extname
        return '' if !file_name and !name

        if file_name.blank?
         File.extname(name)
        else
          File.extname(file_name.to_s)
        end
      end

      def has_extname?(*extensions)
        return false if !file_name and !name

        extensions.all? { |e| extname == e }
      end

      def to_s
        path
      end

      def basename
        File.basename(name).scan(/^([^.]+)(?:\..+)?/).flatten.first
      end

      def <=>(other)
        return false unless file_name

        file_name <=> other.file_name
      end

      def eql?(other)
        return false unless file_name

        file_name.eql? other.file_name
      end

      def similar?(other)
        return true if eql? other

        basename == other.basename
      end

      def hash
        file_name.hash
      end
    end
  end
end
