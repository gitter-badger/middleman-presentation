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

      desc 'slide NAME(S)', 'Create a new slide(s) or edit existing ones. If you want to create multiple slides enter them with a space between the names "01 02 03".'
      option :edit, default: Middleman::Presentation.config.edit, desc: 'Start ENV["EDITOR"] to edit slide.', aliases: %w{-e}
      option :editor_command, default: Middleman::Presentation.config.editor_command, desc: 'editor command to be used, e.g. ENV["EDITOR"] --servername presentation --remote-tab'
      option :error_on_duplicates, type: :boolean, default: Middleman::Presentation.config.error_on_duplicates, desc: 'Raise an error if a slide of the same base name alread exists, e.g. Filename: 01.html.erb => Basename: 01'
      option :title, desc: 'Title of slide'
      def slide(*names)
        fail ArgumentError, I18n.t('errors.missing_argument', argument: 'name') if names.blank?

        shared_instance = ::Middleman::Application.server.inst

        # This only exists when the config.rb sets it!
        if shared_instance.extensions.key? :presentation
          presentation_inst = shared_instance.extensions[:presentation]

          existing_slides = Middleman::Presentation::SlideList.new(Dir.glob(File.join(shared_instance.source_dir, presentation_inst.options.slides_directory, '**', '*'))) do |l| 
            l.transform_with Middleman::Presentation::Transformers::GroupNameFilesystem.new File.join(shared_instance.source_dir, presentation_inst.options.slides_directory)
            l.transform_with Middleman::Presentation::Transformers::SlidePath.new File.join(shared_instance.source_dir, presentation_inst.options.slides_directory)
            l.transform_with Middleman::Presentation::Transformers::FileKeeper.new
          end

          slide_list = Middleman::Presentation::SlideList.new(names) do |l|
            l.transform_with Middleman::Presentation::Transformers::GroupNameCmdline.new
            l.transform_with Middleman::Presentation::Transformers::SlidePath.new File.join(shared_instance.source_dir, presentation_inst.options.slides_directory)
            l.transform_with Middleman::Presentation::Transformers::TemplateFinder.new File.join(shared_instance.root)
            l.transform_with Middleman::Presentation::Transformers::RemoveDuplicateSlides.new(additional_slides: existing_slides, raise_error: options[:error_on_duplicates])
            l.transform_with Middleman::Presentation::Transformers::SortSlides.new
          end

          slide_list.each_new { |slide| 
            create_file slide.path, slide.content(title: options[:title])
          }

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
              $stderr.puts I18n.t('errors.missing_data_attribute', message: e.message)
            end
            editor.concat slide_list.existing_slides

            system(editor.join(" "))
          end
        else
          raise Thor::Error.new 'You need to activate the presentation extension in config.rb before you can create a slide.'
        end
      end
    end
  end
end
