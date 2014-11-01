# encoding: utf-8
module Middleman
  module Presentation
    # Helper module
    module Helpers
      # Slides helpers
      module Slides
        # Yield slides
        def yield_slides
          environment = Middleman::Presentation::MiddlemanEnvironment.new
          configuration_file = Middleman::Presentation::ConfigurationFile.new
          root_directory = configuration_file.directory

          list = SlideList.new(Dir.glob(File.join(environment.slides_directory, '**', '*')), slide_builder: ExistingSlide, base_path: environment.sources_directory) do |l|
            l.transform_with Transformers::FileKeeper.new
            l.transform_with Transformers::RemoveDuplicateSlides.new raise_error: true
            l.transform_with Transformers::IgnoreSlides.new ignore_file: File.join(root_directory, Middleman::Presentation.config.slides_ignore_file)
            l.transform_with Transformers::SortSlides.new
            l.transform_with Transformers::GroupSlides.new template: Erubis::Eruby.new(GroupTemplate.new(working_directory: root_directory).content)
          end

          list.all.map do |element|
            begin
              element.render { |path| render_template(path, {}, layout: nil).chomp }
            rescue StandardError => e
              message = []
              message << "Rendering slide \"#{element.partial_path}\" failed with"
              message << e.class.to_s + ': ' + e.message
              message << e.backtrace.join("\n")

              raise e.class, message.join("\n\n")
            end
          end.join("\n")
        end
      end
    end
  end
end
