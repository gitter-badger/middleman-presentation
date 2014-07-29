# encoding: utf-8
module Middleman
  module Presentation
    module Helpers
      # Yield slides
      def yield_slides
        
        list = SlideList.new Dir.glob(File.join(source_dir, extensions[:presentation].options.slides_directory, '**', '*')) do |l|
          l.transform_with Transformers::GroupNameFilesystem.new File.join(source_dir, extensions[:presentation].options.slides_directory)
          l.transform_with Transformers::SlidePath.new File.join(source_dir, extensions[:presentation].options.slides_directory)
          l.transform_with Transformers::FileKeeper.new
          l.transform_with Transformers::RemoveDuplicateSlides.new raise_error: true
          l.transform_with Transformers::IgnoreSlides.new ignore_file: File.join(root, extensions[:presentation].options.slides_ignore_file)
          l.transform_with Transformers::ReadContent.new
          l.transform_with Transformers::SortSlides.new
          l.transform_with Transformers::GroupSlides.new header: File.expand_path('../../../../templates/slides/group.header.erb.tt', __FILE__), footer: File.expand_path('../../../../templates/slides/group.footer.erb.tt', __FILE__)
        end

        list.all.map do |element|
          begin
            if element.group?
              result = []
              result << element.header
              result.concat element.slides.map { |e| partial(e.partial_path).chomp }
              result << element.footer
              result.join("\n")
            else
              partial element.partial_path
            end
          rescue StandardError => e

            message = []
            message << "Rendering slide \"#{slide.partial_path}\" failed with"
            message << e.class.to_s + ": " + e.message
            message << e.backtrace.join("\n")

            raise e.class, message.join("\n\n")
          end
        end.join("\n")
      end
    end
  end
end
