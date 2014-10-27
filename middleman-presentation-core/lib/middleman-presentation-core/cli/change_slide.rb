# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Create slide
      class ChangeSlide < BaseGroup
        class_option :edit, default: Middleman::Presentation.config.edit_changed_slide, desc: Middleman::Presentation.t('views.application.options.edit')
        class_option :editor_command, default: Middleman::Presentation.config.editor_command, desc: Middleman::Presentation.t('views.application.options.editor_command')
        class_option :error_on_duplicates, type: :boolean, default: Middleman::Presentation.config.error_on_duplicates, desc: Middleman::Presentation.t('views.slides.change.options.error_on_duplicates')
        class_option :base_name, desc: Middleman::Presentation.t('views.slides.change.options.base_name')
        class_option :type, desc: Middleman::Presentation.t('views.slides.change.options.type')

        argument :names, type: :array, desc: Middleman::Presentation.t('views.slides.change.arguments.names')
        def change_slide
          enable_debug_mode

          fail ArgumentError, Middleman::Presentation.t('errors.too_many_arguments', count: 1) if names.count > 1 && options.key?('base_name')
          fail ArgumentError, Middleman::Presentation.t('errors.missing_argument', argument: 'name') if names.blank?

          shared_instance = proc { ::Middleman::Application.server.inst }.call
          fail Thor::Error, Middleman::Presentation.t('errors.extension_not_activated') unless shared_instance.extensions.key? :presentation

          presentation_inst = shared_instance.extensions[:presentation]

          existing_slides = SlideList.new(
            Dir.glob(File.join(shared_instance.source_dir, presentation_inst.options.slides_directory, '**', '*')),
            slide_builder: ExistingSlide,
            base_path: shared_instance.source_dir
          ) do |l|
            l.transform_with Transformers::FileKeeper.new
          end

          slides = []

          names.each do |n|
            old_slide = existing_slides.find { |s| s.base_name == n }

            unless old_slide
              Middleman::Presentation.logger.warn Middleman::Presentation.t('errors.slide_not_found', base_name: n)
              next
            end

            new_slide_file_name = SlideName.new(
              old_slide,
              base_name: options[:base_name],
              type: options[:type]
            )

            new_slide = NewSlide.new(
              File.join(shared_instance.source_dir, presentation_inst.options.slides_directory, new_slide_file_name.to_s),
              base_path: File.join(shared_instance.source_dir, presentation_inst.options.slides_directory)
            )

            slides << OpenStruct.new(old_slide: old_slide, new_slide: new_slide)
          end

          slides.each do |s|
            old_slide = s.old_slide
            new_slide = s.new_slide

            $stderr.puts format('%-20s %-s -> %-s', 'rename '.colorize(color: :blue, mode: :bold), old_slide.relative_path, new_slide.relative_path)
            FileUtils.mv old_slide.path, new_slide.path
          end

          return unless options[:edit]

          data = if shared_instance.data.respond_to? :metadata
                   shared_instance.data.metadata.dup
                 else
                   OpenStruct.new
                 end

          editor = []
          begin
            editor << Erubis::Eruby.new(options[:editor_command]).result(data)
          rescue NameError => e
            $stderr.puts Middleman::Presentation.t('errors.missing_data_attribute', message: e.message)
          end
          editor.concat slides.map { |s| s.new_slide.path }

          Middleman::Presentation.logger.warn Middleman::Presentation.t('infos.open_slide_in_editor', editor: editor.first)
          system(editor.join(' '))
        end
      end
    end
  end
end
