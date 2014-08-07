# encoding: utf-8
module Middleman
  module Presentation
    # A slide
    class NewSlide
      include ComparableSlide

      private

      attr_reader :name, :base_path, :slide_directory_path

      public

      def initialize(name, base_path:)
        @name                 = name
        @slide_directory_path = Pathname.new(base_path)
        @base_path            = @slide_directory_path.dirname
      end

      # Return string representation of self
      def to_s
        path.to_s
      end

      def path
        p = []
        p << Pathname.new(group) unless group.blank?
        p << file_name
        
        p.inject(slide_directory_path) { |a, e| a += e; a}
      end

      def group
        @group ||= extract_group
      end

      # Return basename of slide
      def base_name
        File.basename(name).scan(/^([^.]+)(?:\..+)?/).flatten.first
      end

      def file_name
        path = if type? :erb
          Pathname.new "#{base_name}.html.erb"
        elsif type? :md
          Pathname.new "#{base_name}.html.md"
        elsif type? :liquid
          Pathname.new "#{base_name}.html.liquid"
        else
          Pathname.new("#{base_name}.html") + template.proposed_extname
        end

        Pathname.new(path)
      end

      # Is group?
      def group_object?
        false
      end

      # Write slide content to file
      def write(**data)
        File.open(path, 'wb') do |f|
          f.write(content(**data))
        end
      end

      # Generate slide content
      #
      # It either uses previously set content or generates content by using a
      # predefined template
      def content(**data)
        Erubis::Eruby.new(template.content).result(data)
      end

      private

      def relative_path
        path.relative_path_from(base_path)
      end

      def template
        if type? :erb
          ErbTemplate.new(working_directory: base_path)
        elsif type? :md
          MarkdownTemplate.new(working_directory: base_path)
        elsif type? :liquid
          LiquidTemplate.new(working_directory: base_path)
        else
          CustomTemplate.new(working_directory: base_path)
        end
      end

      # Check type of slide
      def type?(t)
        type == t
      end

      # Determine type of slide
      def type
        return :erb    if extname? '.erb'
        return :md     if extname? '.md', '.markdown', '.mkd'
        return :liquid if extname? '.l', '.liquid'

        :custom
      end

      # Return file extension
      def extname
        File.extname(name)
      end

      # Check if slide has given extensions
      def extname?(*extensions)
        extensions.any? { |e| extname == e }
      end
      
      # Extract group from name
      def extract_group
        group = name.split(/:/).first

        return nil if group == name

        group
      end
    end
  end
end
