# encoding: utf-8
module Middleman
  module Presentation
    module Helpers
      # Yield slides
      def yield_slides
        
        list = SlideList.new Dir.glob(File.join(source_dir, extensions[:presentation].options.slides_directory, '*')) do |l|
          l.transform_with Transformers::SlidePath.new File.join(source_dir, extensions[:presentation].options.slides_directory)
          l.transform_with Transformers::FileKeeper.new
          l.transform_with Transformers::RemoveDuplicateSlides.new raise_error: true
          l.transform_with Transformers::IgnoreSlides.new ignore_file: File.join(root, extensions[:presentation].options.slides_ignore_file)
          l.transform_with Transformers::ReadContent.new
          l.transform_with Transformers::SortSlides.new
        end

        list.all.map do |slide|
          begin
            partial slide.partial_path
          rescue StandardError => e

            message = []
            message << "Rendering slide \"#{s.relative_path}\" failed with"
            message << e.class.to_s + ": " + e.message
            message << e.backtrace.join("\n")

            raise e.class, message.join("\n\n")
          end
        end.join("\n")
      end
    end
  end
end
