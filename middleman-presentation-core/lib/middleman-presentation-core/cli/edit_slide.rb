# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Create slide
      class EditSlide < BaseGroup
        class_option :editor_command, default: Middleman::Presentation.config.editor_command, desc: Middleman::Presentation.t('views.application.options.editor_command')

        argument :names, default: [], required: false, type: :array, desc: Middleman::Presentation.t('views.slides.edit.arguments.names')
        def edit_slide
          enable_debug_mode

          shared_instance = proc { ::Middleman::Application.server.inst }.call
          fail Thor::Error, Middleman::Presentation.t('errors.extension_not_activated') unless shared_instance.extensions.key? :presentation

          presentation_inst = shared_instance.extensions[:presentation]

          slides = SlideList.new(
            Dir.glob(File.join(shared_instance.source_dir, presentation_inst.options.slides_directory, '**', '*')),
            slide_builder: ExistingSlide,
            base_path: shared_instance.source_dir
          ) do |l|
            l.transform_with Transformers::FileKeeper.new
          end

          found_slides = slides.find_all do |s| 
            if names.blank?
              true
            else
              names.include?(s.base_name)
            end
          end

          open_in_editor found_slides.sort.map(&:path)
        end
      end
    end
  end
end
