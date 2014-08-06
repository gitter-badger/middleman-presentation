# encoding: utf-8
module Middleman
  module Presentation
    # Extract css classes from html files
    class CssClassExtracter
      # Extracted css class
      class CssClass
        attr_reader :name, :files

        def initialize(name:, files: [])
          @name  = name
          @files = files.to_a
        end
      end

      def extract(paths, ignore: [])
        classes = build(paths)
        classes.delete_if { |klass| ignore.include? klass }.sort_by { |klass, _| klass }.map { |klass, files| CssClass.new(name: klass, files: files) }
      end

      private

      def build(paths)
        paths.each_with_object({}) do |f, a|
          page = Nokogiri::HTML(open(f))

          page.traverse do |n|
            if n['class']
              klasses = n['class'].split(/ /)

              klasses.each do |k|
                a[k] ||= Set.new
                a[k] << File.basename(f)
              end
            end
          end
        end
      end
    end
  end
end
