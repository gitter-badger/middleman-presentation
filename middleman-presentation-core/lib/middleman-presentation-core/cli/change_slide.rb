# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Create slide
      class ChangeSlide < BaseGroup
        class_option :edit, type: :boolean, default: Middleman::Presentation.config.edit_changed_slide, desc: Middleman::Presentation.t('views.application.options.edit')
        class_option :editor_command, default: Middleman::Presentation.config.editor_command, desc: Middleman::Presentation.t('views.application.options.editor_command')
        class_option :error_on_duplicates, type: :boolean, default: Middleman::Presentation.config.error_on_duplicates, desc: Middleman::Presentation.t('views.slides.change.options.error_on_duplicates')
        class_option :base_name, desc: Middleman::Presentation.t('views.slides.change.options.base_name')
        class_option :type, desc: Middleman::Presentation.t('views.slides.change.options.type')
        class_option :regex, type: :boolean, default: Middleman::Presentation.config.use_regex, desc: Middleman::Presentation.t('views.application.options.regex')

        argument :names, required: false, default: [], type: :array, desc: Middleman::Presentation.t('views.slides.change.arguments.names')
        def make_middleman_environment_available
          @environment = MiddlemanEnvironment.new
        end

        def change_slide
          enable_debug_mode

          fail ArgumentError, Middleman::Presentation.t('errors.too_many_arguments', count: 1) if names.count > 1 && options.key?('base_name')

          existing_slides = SlideList.new(
            Dir.glob(File.join(@environment.slides_directory, '**', '*')),
            slide_builder: ExistingSlide,
            base_path: @environment.sources_directory
          ) do |l|
            l.transform_with Transformers::FileKeeper.new
          end

          found_slides = existing_slides.select do |s|
            if names.blank?
              true
            else
              if options[:regex]
                names.any? { |n| s.base_name =~ /#{n}/ }
              else
                names.any? { |n| s.base_name == n }
              end
            end
          end

          if found_slides.blank?
            Middleman::Presentation.logger.warn Middleman::Presentation.t('errors.slide_not_found', patterns: names.to_list)
            return
          end

          move_jobs = found_slides.sort.map do |old_slide|
            new_slide_file_name = SlideName.new(
              old_slide,
              base_name: options[:base_name],
              type: options[:type]
            )

            new_slide = NewSlide.new(
              File.join(@environment.slides_directory, new_slide_file_name.to_s),
              base_path: @environment.slides_directory
            )

            OpenStruct.new(
              source: old_slide,
              destination: new_slide
            )
          end

          move_jobs.each do |j|
            if j.source == j.destination
              $stderr.puts format('%-20s %-s -> %-s', 'ignore'.colorize(color: :yellow, mode: :bold), j.source.relative_path, j.destination.relative_path)
              next
            end

            $stderr.puts format('%-20s %-s -> %-s', 'rename '.colorize(color: :green, mode: :bold), j.source.relative_path, j.destination.relative_path)
            FileUtils.mv j.source.path, j.destination.path, force: true
          end

          invoke 'middleman:presentation:cli:edit_slide', move_jobs.map(&:destination).map(&:base_name), options.extract!('editor_command') if options['edit']
        end
      end
    end
  end
end
