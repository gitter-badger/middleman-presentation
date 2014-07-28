# encoding: utf-8
module Middleman
  module Presentation
    module Helpers
      # Yield slides
      def yield_slides
        
        list = SlideList.new File.join(source_dir, extensions[:presentation].options.slides_directory) do |l|
          l.transform_with Transformers::SlidePath.new File.join(source_dir, extensions[:presentation].options.slides_directory)
          #l.transform_with Transformers::IgnoreSlides.new File.join(root, extensions[:presentation].options.ignore_file)
          l.transform_with Transformers::SortSlides.new
        end

        repo.all.sort.collect do |s|
          begin
            partial s.relative_as_partial(source_dir)
          rescue StandardError => e

            message = []
            message << "Rendering slide \"#{s.pathname}\" failed with"
            message << e.class.to_s + ": " + e.message
            message << e.backtrace.join("\n")

            raise e.class, message.join("\n\n")
          end
        end.join("\n")
      end
    end
  end
end
