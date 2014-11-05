# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Initialize presentation
      class CreatePresentation < BaseGroup
        include Thor::Actions

        class_option :speaker, required: true, default: Middleman::Presentation.config.speaker, desc: Middleman::Presentation.t('views.presentations.create.options.speaker')
        class_option :title, required: true, desc: Middleman::Presentation.t('views.presentations.create.options.title')
        class_option :date, required: true, default: Time.now.strftime('%d.%m.%Y'), desc: Middleman::Presentation.t('views.presentations.create.options.date')
        class_option :license, required: true, default: Middleman::Presentation.config.license, desc: Middleman::Presentation.t('views.presentations.create.options.license')

        class_option :author, default: Middleman::Presentation.config.author, desc: Middleman::Presentation.t('views.presentations.create.options.author')
        class_option :description, desc: Middleman::Presentation.t('views.presentations.create.options.description')
        class_option :subtitle, desc: Middleman::Presentation.t('views.presentations.create.options.subtitle')
        class_option :homepage, default: Middleman::Presentation.config.homepage, desc: Middleman::Presentation.t('views.presentations.create.options.homepage')
        class_option :company, default: Middleman::Presentation.config.company, desc: Middleman::Presentation.t('views.presentations.create.options.company')
        class_option :location, default: Middleman::Presentation.config.location, desc: Middleman::Presentation.t('views.presentations.create.options.location')
        class_option :audience, default: Middleman::Presentation.config.audience, desc: Middleman::Presentation.t('views.presentations.create.options.audience')

        class_option :phone_number, default: Middleman::Presentation.config.phone_number, desc: Middleman::Presentation.t('views.presentations.create.options.phone_number')
        class_option :email_address, default: Middleman::Presentation.config.email_address, desc: Middleman::Presentation.t('views.presentations.create.options.email_address')
        class_option :github_url, default: Middleman::Presentation.config.github_url, desc: Middleman::Presentation.t('views.presentations.create.options.github_url')

        class_option :width, default: Middleman::Presentation.config.width, desc: Middleman::Presentation.t('views.presentations.create.options.width')
        class_option :height, default: Middleman::Presentation.config.height, desc: Middleman::Presentation.t('views.presentations.create.options.height')
        class_option :margin, default: Middleman::Presentation.config.margin, desc: Middleman::Presentation.t('views.presentations.create.options.margin')
        class_option :min_scale, default: Middleman::Presentation.config.min_scale, desc: Middleman::Presentation.t('views.presentations.create.options.min_scale')
        class_option :max_scale, default: Middleman::Presentation.config.max_scale, desc: Middleman::Presentation.t('views.presentations.create.options.max_scale')
        class_option :activate_center, type: :boolean, default: Middleman::Presentation.config.activate_center, desc: Middleman::Presentation.t('views.presentations.create.options.activate_center')
        class_option :activate_controls, type: :boolean, default: Middleman::Presentation.config.activate_controls, desc: Middleman::Presentation.t('views.presentations.create.options.activate_controls')
        class_option :activate_embedded, type: :boolean, default: Middleman::Presentation.config.activate_embedded, desc: Middleman::Presentation.t('views.presentations.create.options.activate_embedded')
        class_option :activate_fragments, type: :boolean, default: Middleman::Presentation.config.activate_fragments, desc: Middleman::Presentation.t('views.presentations.create.options.activate_fragments')
        class_option :activate_history, type: :boolean, default: Middleman::Presentation.config.activate_history, desc: Middleman::Presentation.t('views.presentations.create.options.activate_history')
        class_option :activate_history, type: :boolean, default: Middleman::Presentation.config.activate_history, desc: Middleman::Presentation.t('views.presentations.create.options.activate_history')
        class_option :activate_keyboard, type: :boolean, default: Middleman::Presentation.config.activate_keyboard, desc: Middleman::Presentation.t('views.presentations.create.options.activate_keyboard')
        class_option :activate_loop, type: :boolean, default: Middleman::Presentation.config.activate_loop, desc: Middleman::Presentation.t('views.presentations.create.options.activate_loop')
        class_option :activate_mouse_wheel, type: :boolean, default: Middleman::Presentation.config.activate_mouse_wheel, desc: Middleman::Presentation.t('views.presentations.create.options.activate_mouse_wheel')
        class_option :activate_overview, type: :boolean, default: Middleman::Presentation.config.activate_overview, desc: Middleman::Presentation.t('views.presentations.create.options.activate_overview')
        class_option :activate_progress, type: :boolean, default: Middleman::Presentation.config.activate_progress, desc: Middleman::Presentation.t('views.presentations.create.options.activate_progress')
        class_option :activate_rtl, type: :boolean, default: Middleman::Presentation.config.activate_rtl, desc: Middleman::Presentation.t('views.presentations.create.options.activate_rtl')
        class_option :activate_slide_number, type: :boolean, default: Middleman::Presentation.config.activate_slide_number, desc: Middleman::Presentation.t('views.presentations.create.options.activate_slide_number')
        class_option :activate_touch, type: :boolean, default: Middleman::Presentation.config.activate_touch, desc: Middleman::Presentation.t('views.presentations.create.options.activate_touch')
        class_option :auto_slide, type: :numeric, default: Middleman::Presentation.config.auto_slide, desc: Middleman::Presentation.t('views.presentations.create.options.auto_slide')
        class_option :auto_slide_stoppable, type: :boolean, default: Middleman::Presentation.config.auto_slide_stoppable, desc: Middleman::Presentation.t('views.presentations.create.options.auto_slide_stoppable')
        class_option :default_background_transition, default: Middleman::Presentation.config.default_background_transition, desc: Middleman::Presentation.t('views.presentations.create.options.default_background_transition')
        class_option :default_transition_speed, default: Middleman::Presentation.config.default_transition_speed, desc: Middleman::Presentation.t('views.presentations.create.options.default_transition_speed')
        class_option :default_transition_type, default: Middleman::Presentation.config.default_transition_type, desc: Middleman::Presentation.t('views.presentations.create.options.default_transition_type')
        class_option :hide_address_bar, type: :boolean, default: Middleman::Presentation.config.hide_address_bar, desc: Middleman::Presentation.t('views.presentations.create.options.hide_address_bar')
        class_option :parallax_background_image, default: Middleman::Presentation.config.parallax_background_image, desc: Middleman::Presentation.t('views.presentations.create.options.parallax_background_image')
        class_option :parallax_background_size, default: Middleman::Presentation.config.parallax_background_size, desc: Middleman::Presentation.t('views.presentations.create.options.parallax_background_size')
        class_option :preview_links, type: :boolean, default: Middleman::Presentation.config.preview_links, desc: Middleman::Presentation.t('views.presentations.create.options.preview_links')
        class_option :view_distance, type: :numeric, default: Middleman::Presentation.config.view_distance, desc: Middleman::Presentation.t('views.presentations.create.options.view_distance')

        class_option :install_assets, type: :boolean, default: Middleman::Presentation.config.install_assets, desc: Middleman::Presentation.t('views.presentations.create.options.install_assets')
        class_option :initialize_git, type: :boolean, default: Middleman::Presentation.config.initialize_git, desc: Middleman::Presentation.t('views.presentations.create.options.initialize_git')
        class_option :check_for_bower, type: :boolean, default: Middleman::Presentation.config.check_for_bower, desc: Middleman::Presentation.t('views.presentations.create.options.check_for_bower')

        class_option :create_predefined_slides, type: :boolean, default: Middleman::Presentation.config.create_predefined_slides, desc: Middleman::Presentation.t('views.presentations.create.options.create_predefined_slides')

        class_option :language, default: Middleman::Presentation.config.presentation_language, desc: Middleman::Presentation.t('views.presentations.create.options.language')
        class_option :version, default: Middleman::Presentation.config.default_version_number, desc: Middleman::Presentation.t('views.presentations.create.options.version')
        class_option :force, type: :boolean, default: Middleman::Presentation.config.force_create_presentation, desc: Middleman::Presentation.t('views.presentations.create.options.force')
        class_option :runtime_environment, default: Middleman::Presentation.config.runtime_environment, desc: Middleman::Presentation.t('views.presentations.create.options.runtime_environment')

        class_option :sources_directory, default: Middleman::Presentation.config.sources_directory, desc: Middleman::Presentation.t('views.presentations.create.options.sources_directory')
        class_option :images_directory, default: Middleman::Presentation.config.images_directory, desc: Middleman::Presentation.t('views.presentations.create.options.images_directory')
        class_option :scripts_directory, default: Middleman::Presentation.config.scripts_directory, desc: Middleman::Presentation.t('views.presentations.create.options.scripts_directory')
        class_option :stylesheets_directory, default: Middleman::Presentation.config.stylesheets_directory, desc: Middleman::Presentation.t('views.presentations.create.options.stylesheets_directory')
        class_option :fonts_directory, default: Middleman::Presentation.config.fonts_directory, desc: Middleman::Presentation.t('views.presentations.create.options.fonts_directory')
        class_option :build_directory, default: Middleman::Presentation.config.build_directory, desc: Middleman::Presentation.t('views.presentations.create.options.build_directory')

        argument :directory, default: Dir.getwd, desc: Middleman::Presentation.t('views.presentations.create.arguments.directory')

        desc Middleman::Presentation.t('views.presentations.create.title')

        def initialize_generator
          enable_debug_mode
        end

        def add_to_sources_path
          source_paths << File.expand_path('../../../../templates', __FILE__)
        end

        def set_language
          @language = FeduxOrgStdlib::ShellLanguageDetector.new.detect(
            allowed: Middleman::Presentation.locale_configurator.available_locales,
            overwrite: options[:language]
          ).language_code
        end

        def set_variables_for_templates
          Middleman::Presentation.config.author          = options[:author]
          Middleman::Presentation.config.speaker         = options[:speaker]
          Middleman::Presentation.config.title           = options[:title]
          Middleman::Presentation.config.description     = options[:description]
          Middleman::Presentation.config.subtitle        = options[:subtitle]
          Middleman::Presentation.config.date            = options[:date]
          Middleman::Presentation.config.homepage        = options[:homepage]
          Middleman::Presentation.config.company         = options[:company]
          Middleman::Presentation.config.license         = options[:license]
          Middleman::Presentation.config.location        = options[:location]
          Middleman::Presentation.config.audience        = options[:audience]

          Middleman::Presentation.config.email_address   = options[:email_address]
          Middleman::Presentation.config.phone_number    = options[:phone_number]
          Middleman::Presentation.config.github_url      = options[:github_url]

          Middleman::Presentation.config.version         = options[:version]
          Middleman::Presentation.config.project_id      = format '%s-%s', ActiveSupport::Inflector.transliterate(options[:title]).parameterize, SecureRandom.hex

          Middleman::Presentation.config.width                         = options[:width]
          Middleman::Presentation.config.height                        = options[:height]
          Middleman::Presentation.config.margin                        = options[:margin]
          Middleman::Presentation.config.min_scale                     = options[:min_scale]
          Middleman::Presentation.config.max_scale                     = options[:max_scale]
          Middleman::Presentation.config.activate_center               = options[:activate_center]
          Middleman::Presentation.config.activate_controls             = options[:activate_controls]
          Middleman::Presentation.config.activate_embedded             = options[:activate_embedded]
          Middleman::Presentation.config.activate_fragments            = options[:activate_fragments]
          Middleman::Presentation.config.activate_history              = options[:activate_history]
          Middleman::Presentation.config.activate_history              = options[:activate_history]
          Middleman::Presentation.config.activate_keyboard             = options[:activate_keyboard]
          Middleman::Presentation.config.activate_loop                 = options[:activate_loop]
          Middleman::Presentation.config.activate_mouse_wheel          = options[:activate_mouse_wheel]
          Middleman::Presentation.config.activate_overview             = options[:activate_overview]
          Middleman::Presentation.config.activate_progress             = options[:activate_progress]
          Middleman::Presentation.config.activate_rtl                  = options[:activate_rtl]
          Middleman::Presentation.config.activate_slide_number         = options[:activate_slide_number]
          Middleman::Presentation.config.activate_touch                = options[:activate_touch]
          Middleman::Presentation.config.auto_slide                    = options[:auto_slide]
          Middleman::Presentation.config.auto_slide_stoppable          = options[:auto_slide_stoppable]
          Middleman::Presentation.config.default_background_transition = options[:default_background_transition]
          Middleman::Presentation.config.default_transition_speed      = options[:default_transition_speed]
          Middleman::Presentation.config.default_transition_type       = options[:default_transition_type]
          Middleman::Presentation.config.hide_address_bar              = options[:hide_address_bar]
          Middleman::Presentation.config.parallax_background_image     = options[:parallax_background_image]
          Middleman::Presentation.config.parallax_background_size      = options[:parallax_background_size]
          Middleman::Presentation.config.preview_links                 = options[:preview_links]
          Middleman::Presentation.config.view_distance                 = options[:view_distance]

          Middleman::Presentation.config.bower_directory          = options[:bower_directory]

          Middleman::Presentation.config.runtime_environment      = options[:runtime_environment]

          Middleman::Presentation.config.sources_directory = options[:sources_directory]
          Middleman::Presentation.config.images_directory = options[:images_directory]
          Middleman::Presentation.config.scripts_directory = options[:scripts_directory]
          Middleman::Presentation.config.stylesheets_directory = options[:stylesheets_directory]
          Middleman::Presentation.config.fonts_directory = options[:fonts_directory]
          Middleman::Presentation.config.build_directory = options[:build_directory]
        end

        def create_root_directory
          empty_directory directory, force: options[:force]
        end

        def create_source_directory
          [
            :sources_path,
            :images_path,
            :scripts_path,
            :stylesheets_path,
            :fonts_path,
            :build_path
          ].each do |dir|
            empty_directory middleman_environment.public_send(dir), force: options[:force]
          end
        end

        def create_gemfile
          template 'Gemfile.tt', File.join(middleman_environment.root_path, 'Gemfile'), force: options[:force]
        end

        def create_config_file
          create_file(
            File.join(middleman_environment.root_path, '.middleman-presentation.yaml'),
            Middleman::Presentation.config.to_yaml(keys: Middleman::Presentation.config.exportable_options, remove_blank: true),
            force: options[:force]
          )
        end

        def create_bower_configuration_files
          assets_loader.load_for_bower_update

          @bower_directory = middleman_environment.bower_directory
          template '.bowerrc.tt', File.join(middleman_environment.root_path, '.bowerrc'), force: options[:force]
          template 'bower.json.tt', File.join(middleman_environment.root_path, 'bower.json'), force: options[:force]
        end

        def create_rake_file
          template 'Rakefile', File.join(middleman_environment.root_path, 'Rakefile'), force: options[:force]
        end

        def create_slides_ignore_file
          create_file File.join(middleman_environment.root_path, Middleman::Presentation.config.slides_ignore_file), "# empty\n", force: options[:force]
        end

        def add_configuration_for_middleman_presentation
          template 'config.rb.tt', File.join(middleman_environment.root_path, 'config.rb'), force: options[:force]
        end

        def add_patterns_to_gitignore
          template 'gitignore.tt', File.join(middleman_environment.root_path, '.gitignore'), force: options[:force]
        end

        def create_presentation_layout
          template 'source/layout.erb', File.join(middleman_environment.sources_path, 'layout.erb'), force: options[:force]
          copy_file 'source/index.html.erb', File.join(middleman_environment.sources_path, 'index.html.erb'), force: options[:force]
        end

        def create_default_slides
          return unless options[:create_predefined_slides]

          PredefinedSlideTemplateDirectory.new(working_directory: middleman_environment.root_path).template_files.each do |file|
            template file,
                     File.join(
                       middleman_environment.sources_path,
                       Middleman::Presentation.config.slides_directory,
                       File.basename(file, '.tt')
                   ),
                     force: options[:force]
          end
        end

        def create_default_license_file_to_presentation
          copy_file 'LICENSE.presentation', File.join(middleman_environment.root_path, 'LICENSE.presentation'), force: options[:force]
        end

        def create_helper_scripts
          %w(start bootstrap slide presentation build export).each do |s|
            copy_file File.join('script', s), File.join(middleman_environment.root_path, 'script', s), force: options[:force]
            chmod File.join(middleman_environment.root_path, 'script', s), 0755, force: options[:force]
          end
        end

        def install_components
          inside directory do
            fail Thor::Error, Middleman::Presentation.t('errors.bower_command_not_found', path: ENV['PATH']) if options[:check_for_bower] && File.which('bower').blank?

            result = run('bower update', capture: true) if options[:install_assets] == true
            fail Thor::Error, Middleman::Presentation.t('errors.bower_command_failed', result: result) unless $CHILD_STATUS.exitstatus == 0
          end
        end

        def install_gems
          inside directory do
            Bundler.with_clean_env do
              result = run('bundle install', capture: true) if options[:install_assets] == true
              fail Thor::Error, Middleman::Presentation.t('errors.bundle_command_failed', result: result) unless $CHILD_STATUS.exitstatus == 0
            end
          end
        end

        def create_application_asset_files
          assets_loader.load_for_asset_aggregators

          template 'source/stylesheets/application.scss.tt', File.join(middleman_environment.sources_path, 'stylesheets', 'application.scss'), force: options[:force]
          template 'source/javascripts/application.js.tt', File.join(middleman_environment.sources_path, 'javascripts', 'application.js'), force: options[:force]
        end

        def initialize_git_directory
          return unless options[:initialize_git]

          inside directory do
            run 'git init'
            run 'git add -A .'
            run 'git commit -m Init'
          end
        end

        no_commands do
          # Overwrite for assets_loader
          def middleman_environment
            return @middleman_environment if @middleman_environment

            Dir.chdir directory do
              @middleman_environment = MiddlemanEnvironment.new(strict: false)
              @middleman_environment.root_path
            end

            @middleman_environment
          end

          def bower_path
            return @bower_path if @bower_path

            environment = MiddlemanEnvironment.new(strict: false)
            @bower_path = File.join(environment.root_path, directory, environment.bower_directory)
          end
        end
      end
    end
  end
end
