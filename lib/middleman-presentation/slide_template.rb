# encoding: utf-8
module Middleman
  module Presentation
    class SlideTemplate
      private

      attr_reader :name, :base_path, :extensions, :default_extension, :default_type

      public

      def initialize(options = {})
        @name      = options.fetch(:name)
        @base_path = options.fetch(:base_path)
        @default_extension = options.fetch(:default_extension, '.html.erb')
        @default_type = options.fetch(:default_type, :erb)

        @extensions = {
          erb: '.html.erb',
          md: '.html.md',
          liquid: '.html.liquid',
        }
      end

      def file_path
        File.join(base_path, basename(name)  + filename_extension)
      end

      def type
        return :erb if extension? name, '.erb'
        return :md  if extension? name, '.md'
        return :md  if extension? name, '.markdown'
        return :liquid  if extension? name, '.liquid'
        return :liquid  if extension? name, '.l'

        default_type
      end

      private

      def filename_extension
        return extensions[:erb] if extension? name, '.erb'
        return extensions[:md]  if extension? name, '.md'
        return extensions[:md]  if extension? name, '.markdown'
        return extensions[:liquid]  if extension? name, '.liquid'
        return extensions[:liquid]  if extension? name, '.l'

        default_extension
      end

      def extension?(path, ext)
        Pathname.new(path).extname == ext
      end

      def basename(path)
        Pathname.new(path).basename.to_s.scan(/^([^.]+)/).flatten.first
      end
    end
  end
end
