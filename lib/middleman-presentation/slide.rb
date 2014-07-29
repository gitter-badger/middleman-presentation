# encoding: utf-8
module Middleman
  module Presentation
    class Slide
      include Comparable

      attr_accessor :name, :template, :path, :type, :partial_path
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

      def file_name
        File.basename path.to_s
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
        return '' if !path and !name

        if path.blank?
          File.extname(name)
        else
          File.extname(path)
        end
      end

      def match?(string_or_regex)
        regex = if string_or_regex.is_a? String
                  Regexp.new(string_or_regex)
                else
                  string_or_regex
                end

        regex === path
      end

      def has_extname?(*extensions)
        return false if !path and !name

        extensions.any? { |e| extname == e }
      end

      def to_s
        path
      end

      def basename
        File.basename(name).scan(/^([^.]+)(?:\..+)?/).flatten.first
      end

      def <=>(other)
        return false unless path

        path <=> other.path
      end

      def eql?(other)
        return false unless path

        path.eql? other.path
      end

      def similar?(other)
        return true if eql? other

        basename == other.basename
      end

      def hash
        path.hash
      end
    end
  end
end
