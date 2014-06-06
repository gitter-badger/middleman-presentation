# encoding: utf-8
module Middleman
  module Presentation
    module Helpers
      # Yield slides
      def yield_slides
        repo = Presentation::SlideRepository.new(File.join(source_dir, extensions[:presentation].options.slides_directory))

        repo.all.sort.collect do |s|
          begin
            partial s.relative_as_partial(source_dir)
          rescue StandardError => e

            message = []
            message << "Rendering slide \"#{s.pathname}\" failed with"
            message << e.message
            message << e.backtrace.join("\n")

            raise e.class, message.join("\n\n")
          end
        end.join("\n")
      end
    end
  end
end
