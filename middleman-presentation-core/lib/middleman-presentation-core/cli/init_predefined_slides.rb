# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'create presentation' command for the middleman CLI.
      class InitPredefinedSlides < BaseGroup
        include Thor::Actions

        class_option :directory, default: PredefinedSlideTemplateDirectory.new.preferred_template_directory, desc: Middleman::Presentation.t('views.predefined_slides.create.options.directory')

        def initialize_generator
          enable_debug_mode
        end

        def add_to_source_path
          source_paths << File.expand_path('../../../../templates', __FILE__)
        end

        def set_variables
          @destination = File.join(options[:directory], File.basename(file))
          @source      = File.expand_path('../../../../templates', __FILE__)
        end

        def copy_templates
          PredefinedSlideTemplateDirectory.new(working_directory: @source).template_files.each { |file| copy_file file, @destination }
        end
      end
    end
  end
end
