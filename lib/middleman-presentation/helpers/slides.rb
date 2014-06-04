# encoding: utf-8
module Middleman
  module Presentation
    module Helpers
      # Yield slides
      def yield_slides
        repo = Presentation::SlideRepository.new(File.join(source_dir, extensions[:presentation].options.slides_directory))

        repo.all.sort.collect do |s|
          partial s.relative_as_partial(source_dir)
        end.join("\n")
      end
    end
  end
end
