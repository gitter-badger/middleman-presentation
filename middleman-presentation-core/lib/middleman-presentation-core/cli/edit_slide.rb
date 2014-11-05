# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Create slide
      class EditSlide < BaseGroup
        class_option :editor_command, default: Middleman::Presentation.config.editor_command, desc: Middleman::Presentation.t('views.application.options.editor_command')
        class_option :regex, type: :boolean, default: Middleman::Presentation.config.use_regex, desc: Middleman::Presentation.t('views.application.options.regex')

        argument :names, default: [], required: false, type: :array, desc: Middleman::Presentation.t('views.slides.edit.arguments.names')

        def make_middleman_environment_available
          @environment = MiddlemanEnvironment.new
        end

        def edit_slide
          enable_debug_mode

          existing_slides = SlideList.new(
            Dir.glob(File.join(@environment.slides_path, '**', '*')),
            slide_builder: ExistingSlide,
            base_path: @environment.sources_path
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

          open_in_editor found_slides.sort.map(&:path)
        end
      end
    end
  end
end
