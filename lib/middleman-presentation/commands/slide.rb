# encoding: utf-8
require 'middleman-presentation'

module Middleman
  module Cli
    # This class provides an 'slide' command for the middleman CLI.
    class Slide < Thor
      include Thor::Actions

      check_unknown_options!

      namespace :slide

      def self.source_root
        ENV['MM_ROOT']
      end

      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
      end

      desc 'slide NAME(S)', Middleman::Presentation.t('views.slides.create.title')
      option :edit, default: Middleman::Presentation.config.edit, desc: Middleman::Presentation.t('views.slides.create.options.edit')
      option :editor_command, default: Middleman::Presentation.config.editor_command, desc: Middleman::Presentation.t('views.slides.create.options.editor_command')
      option :error_on_duplicates, type: :boolean, default: Middleman::Presentation.config.error_on_duplicates, desc: Middleman::Presentation.t('views.slides.create.options.error_on_duplicates')
      option :title, desc: Middleman::Presentation.t('views.slides.create.options.title')

      argument :names, type: :array, desc: Middleman::Presentation.t('views.slides.create.arguments.names')
      def slide
        fail ArgumentError, Middleman::Presentation.t('errors.missing_argument', argument: 'name') if names.blank?

        shared_instance = ::Middleman::Application.server.inst

        # This only exists when the config.rb sets it!
        if shared_instance.extensions.key? :presentation
          presentation_inst = shared_instance.extensions[:presentation]

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

          data = if shared_instance.data.respond_to? :metadata
                   shared_instance.data.metadata.dup
                 else
                   OpenStruct.new
                 end

          if options[:edit]
            editor = []
            begin
              editor << Erubis::Eruby.new(options[:editor_command]).result(data)
            rescue NameError => e
              $stderr.puts Middleman::Presentation.t('errors.missing_data_attribute', message: e.message)
            end
            editor.concat slide_list.existing_slides

            system(editor.join(' '))
          end
        else
          fail Thor::Error, Middleman::Presentation.t('errors.extension_not_activated')
        end
      end
    end
  end
end
