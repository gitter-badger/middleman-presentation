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

        class_option :bower_directory, default: Middleman::Presentation.config.bower_directory, desc: Middleman::Presentation.t('views.presentations.create.options.bower_directory')
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

        class_option :activate_controls, type: :boolean, default: Middleman::Presentation.config.activate_controls, desc: Middleman::Presentation.t('views.presentations.create.options.activate_controls')
        class_option :activate_progress, type: :boolean, default: Middleman::Presentation.config.activate_progress, desc: Middleman::Presentation.t('views.presentations.create.options.activate_progress')
        class_option :activate_history, type: :boolean, default: Middleman::Presentation.config.activate_history, desc: Middleman::Presentation.t('views.presentations.create.options.activate_history')
        class_option :activate_center, type: :boolean, default: Middleman::Presentation.config.activate_center, desc: Middleman::Presentation.t('views.presentations.create.options.activate_center')
        class_option :activate_slide_number, type: :boolean, default: Middleman::Presentation.config.activate_slide_number, desc: Middleman::Presentation.t('views.presentations.create.options.activate_slide_number')

        class_option :default_transition_type, default: Middleman::Presentation.config.default_transition_type, desc: Middleman::Presentation.t('views.presentations.create.options.default_transition_type')
        class_option :default_transition_speed, default: Middleman::Presentation.config.default_transition_speed, desc: Middleman::Presentation.t('views.presentations.create.options.default_transition_speed')
        class_option :view_port, type: :array, default: Middleman::Presentation.config.view_port, desc: Middleman::Presentation.t('views.presentations.create.options.view_port')

        class_option :install_assets, type: :boolean, default: Middleman::Presentation.config.install_assets, desc: Middleman::Presentation.t('views.presentations.create.options.install_assets')
        class_option :initialize_git, type: :boolean, default: Middleman::Presentation.config.initialize_git, desc: Middleman::Presentation.t('views.presentations.create.options.initialize_git')
        class_option :check_for_bower, type: :boolean, default: Middleman::Presentation.config.check_for_bower, desc: Middleman::Presentation.t('views.presentations.create.options.check_for_bower')

        class_option :create_predefined_slides, type: :boolean, default: Middleman::Presentation.config.create_predefined_slides, desc: Middleman::Presentation.t('views.presentations.create.options.create_predefined_slides')

        class_option :language, default: Middleman::Presentation.config.presentation_language, desc: Middleman::Presentation.t('views.presentations.create.options.language')
        class_option :version, default: Middleman::Presentation.config.default_version_number, desc: Middleman::Presentation.t('views.presentations.create.options.version')
        class_option :force, type: :boolean, default: Middleman::Presentation.config.force_create_presentation, desc: Middleman::Presentation.t('views.presentations.create.options.force')

        argument :directory, default: Dir.getwd, desc: Middleman::Presentation.t('views.presentations.create.arguments.directory')

        desc Middleman::Presentation.t('views.presentations.create.title')

        def initialize_generator
          enable_debug_mode
        end

        def define_root_directory
          @root_directory = File.expand_path directory
        end

        def init_asset_loader
          @asset_loader = Middleman::Presentation::AssetsLoader.new(root_directory: root_directory)
        end

        def add_to_source_path
          source_paths << File.expand_path('../../../../templates', __FILE__)
        end

        def initialize_middleman
          cmd = []
          cmd << 'middleman init'
          cmd << '--skip-bundle'
          cmd << "--template empty #{directory}"
          cmd << '--force' if options[:force]

          # Bundler.with_clean_env { run(cmd.join(' ')) }
          run(cmd.join(' '))

          fail Thor::Error, Middleman::Presentation.t('errors.init_middleman_failed') unless $CHILD_STATUS.exitstatus == 0
        end

        def set_language
          @language = FeduxOrgStdlib::ShellLanguageDetector.new.detect(
            allowed: Middleman::Presentation.locale_configurator.available_locales,
            overwrite: options[:language]
          ).language_code
        end

        def set_variables_for_templates
          @bower_directory = options[:bower_directory]
          @author          = options[:author]
          @speaker         = options[:speaker]
          @title           = options[:title]
          @description     = options[:description]
          @subtitle        = options[:subtitle]
          @date            = options[:date]
          @homepage        = options[:homepage]
          @company         = options[:company]
          @license         = options[:license]
          @location        = options[:location]
          @audience        = options[:audience]

          @email_address   = options[:email_address]
          @phone_number    = options[:phone_number]
          @github_url      = options[:github_url]

          @version         = options[:version]
          @project_id      = format '%s-%s', ActiveSupport::Inflector.transliterate(options[:title]).parameterize, SecureRandom.hex
        end

        def set_configuration_for_revealjs
          @revealjs_config = {}
          @revealjs_config[:controls]                 = options[:activate_controls]
          @revealjs_config[:progress]                 = options[:activate_progress]
          @revealjs_config[:history]                  = options[:activate_history]
          @revealjs_config[:center]                   = options[:activate_center]
          @revealjs_config[:slide_number]             = options[:activate_slide_number]
          @revealjs_config[:default_transition_type]  = options[:default_transition_type]
          @revealjs_config[:default_transition_speed] = options[:default_transition_speed]
          @revealjs_config[:view_port]                = options[:view_port]
        end

        def add_gems_to_gem_file
          if ENV['MP_ENV'] == 'test'
            append_to_file File.join(root_directory, 'Gemfile'), <<-EOS.strip_heredoc, force: options[:force]

              gem 'middleman-presentation', path: File.expand_path('../../../../../', __FILE__)
              gem 'middleman-presentation-core', path: File.expand_path('../../../../../middleman-presentation-core', __FILE__), require: false
              gem 'middleman-presentation-helpers', path: File.expand_path('../../../../../middleman-presentation-helpers', __FILE__), require: false
              gem 'middleman-presentation-simple_plugin', path: File.expand_path('../../../../../middleman-presentation-core/fixtures/middleman-presentation-simple_plugin', __FILE__), require: false
            EOS
          else
            append_to_file File.join(root_directory, 'Gemfile'), <<-EOS.strip_heredoc, force: options[:force]

              gem 'middleman-presentation'
            EOS
          end

          append_to_file File.join(root_directory, 'Gemfile'), <<-EOS.strip_heredoc, force: options[:force]

          group :development, :test do
            gem 'pry'
            gem 'byebug'
            gem 'pry-byebug'
          end

          gem 'kramdown'
          gem 'github-markup'
          gem 'liquid'
          gem 'rake'
          EOS
        end

        def create_middleman_data_files
          template 'data/metadata.yml.tt', File.join(data_directory, 'metadata.yml'), force: options[:force]
          template 'data/config.yml.tt', File.join(data_directory, 'config.yml'), force: options[:force]
        end

        def set_root_directory_for_components_manager
          Middleman::Presentation.frontend_components_manager.bower_directory = File.join(root_directory, bower_directory)
        end

        def create_bower_configuration_files
          asset_loader.load_for_bower_update

          template '.bowerrc.tt', File.join(root_directory, '.bowerrc'), force: options[:force]
          template 'bower.json.tt', File.join(root_directory, 'bower.json'), force: options[:force]
        end

        def create_rake_file
          template 'Rakefile', File.join(root_directory, 'Rakefile'), force: options[:force]
        end

        def create_slides_ignore_file
          create_file File.join(root_directory, '.slidesignore'), "# empty\n", force: options[:force]
        end

        def add_configuration_for_middleman_presentation
          append_to_file File.join(root_directory, 'config.rb'), <<-EOS.strip_heredoc, force: options[:force]
          activate :presentation
          EOS

          if ENV['MP_ENV'] == 'test'
            append_to_file File.join(root_directory, 'config.rb'), <<-EOS.strip_heredoc, force: options[:force]
            # For testing only otherwise config = Middleman::Pre...::Config.new
            # is run before the new home is set and the config file is created
            # and there is not used.
            Middleman::Presentation.config.redetect
            EOS
          end

          append_to_file File.join(root_directory, 'config.rb'), <<-EOS.strip_heredoc, force: options[:force]

          Middleman::Presentation::AssetsLoader.new(root_directory: root).load_at_presentation_runtime
          helpers Middleman::Presentation.helpers_manager.available_helpers

          set :markdown_engine, :kramdown
          set :markdown, parse_block_html: true

          # ignore slides so that a user doesn't need to prepend slide names
          # with an underscore
          ignore 'slides/*'

          bower_directory = '#{bower_directory}'

          if respond_to?(:sprockets) && sprockets.respond_to?(:import_asset)
            Middleman::Presentation.asset_components_manager.each_component { |c| sprockets.append_path c.path }
            sprockets.append_path File.join(root, bower_directory)

            Middleman::Presentation.assets_manager.each_loadable_asset do |a|
              sprockets.import_asset a.load_path, &a.destination_path_resolver
            end
          end
          EOS
        end

        def add_patterns_to_gitignore
          append_to_file File.join(root_directory, '.gitignore'), <<-EOS.strip_heredoc, force: options[:force]
          *.zip
          *.tar.gz
          tmp/
          EOS
        end

        def create_image_directory
          empty_directory File.join(middleman_source_directory, 'images'), force: options[:force]
        end

        def create_presentation_layout
          copy_file 'source/layout.erb', File.join(middleman_source_directory, 'layout.erb'), force: options[:force]
          copy_file 'source/index.html.erb', File.join(middleman_source_directory, 'index.html.erb'), force: options[:force]
        end

        def create_default_slides
          return unless options[:create_predefined_slides]

          PredefinedSlideTemplateDirectory.new(working_directory: root_directory).template_files.each do |file|
            template file, File.join(slides_directory, File.basename(file, '.tt')), force: options[:force]
          end
        end

        def create_default_license_file_to_presentation
          copy_file 'LICENSE.presentation', File.join(root_directory, 'LICENSE.presentation'), force: options[:force]
        end

        def create_helper_scripts
          %w(start bootstrap slide presentation build export).each do |s|
            copy_file File.join('script', s), File.join(root_directory, 'script', s), force: options[:force]
            chmod File.join(root_directory, 'script', s), 0755, force: options[:force]
          end
        end

        def install_frontend_components
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
          asset_loader.load_for_asset_aggregators

          template 'source/stylesheets/application.scss.tt', File.join(middleman_source_directory, 'stylesheets', 'application.scss'), force: options[:force]
          template 'source/javascripts/application.js.tt', File.join(middleman_source_directory, 'javascripts', 'application.js'), force: options[:force]
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
          attr_reader :root_directory, :asset_loader, :bower_directory

          def data_directory
            File.join root_directory, 'data'
          end

          def middleman_source_directory
            File.join root_directory, 'source'
          end

          def slides_directory
            File.join middleman_source_directory, Middleman::Presentation.config.slides_directory
          end
        end
      end
    end
  end
end
