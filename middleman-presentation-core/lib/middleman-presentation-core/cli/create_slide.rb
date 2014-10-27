# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Create slide
      class CreateSlide < BaseGroup
        class_option :edit, default: Middleman::Presentation.config.edit_created_slide, desc: Middleman::Presentation.t('views.application.options.edit')
        class_option :editor_command, default: Middleman::Presentation.config.editor_command, desc: Middleman::Presentation.t('views.application.options.editor_command')
        class_option :error_on_duplicates, type: :boolean, default: Middleman::Presentation.config.error_on_duplicates, desc: Middleman::Presentation.t('views.slides.create.options.error_on_duplicates')
        class_option :title, desc: Middleman::Presentation.t('views.slides.create.options.title')

        argument :names, type: :array, desc: Middleman::Presentation.t('views.slides.create.arguments.names')
        def create_slide
          enable_debug_mode

          existing_slides = Middleman::Presentation::SlideList.new(
            Dir.glob(File.join(shared_instance.source_dir, presentation_inst.options.slides_directory, '**', '*')),
            slide_builder: Middleman::Presentation::ExistingSlide,
            base_path: shared_instance.source_dir
          ) do |l|
            l.transform_with Middleman::Presentation::Transformers::FileKeeper.new
          end

          slide_list = Middleman::Presentation::SlideList.new(
            names,
            slide_builder: Middleman::Presentation::NewSlide,
            base_path: File.join(shared_instance.source_dir, presentation_inst.options.slides_directory)
          ) do |l|
            l.transform_with Middleman::Presentation::Transformers::RemoveDuplicateSlides.new(additional_slides: existing_slides, raise_error: options[:error_on_duplicates])
            l.transform_with Middleman::Presentation::Transformers::SortSlides.new
          end

          slide_list.each_existing do |slide|
            $stderr.puts format('%-20s %-s', 'exist'.colorize(color: :blue, mode: :bold), slide.relative_path)
          end

          slide_list.each_new do |slide|
            $stderr.puts format('%-20s %-s', 'create'.colorize(color: :green, mode: :bold), slide.relative_path)
            slide.write(title: options[:title])
          end

          invoke 'middleman:presentation:cli:edit_slide', names, options.extract!(:editor_command) if options.key?(:edit)
        end
      end
    end
  end
end
