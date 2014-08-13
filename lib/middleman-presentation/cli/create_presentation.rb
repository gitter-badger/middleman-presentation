# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Initialize presentation
      class CreatePresentation < Thor::Group
        include Thor::Actions

        class_option :speaker, required: true, default: Middleman::Presentation.config.speaker, desc: 'Name of speaker'
        class_option :title, required: true, desc: 'Title of presentation'
        class_option :date, required: true, default: Time.now.strftime('%d.%m.%Y'), desc: 'Date of presentation'
        class_option :license, required: true, default: Middleman::Presentation.config.license, desc: 'License of the presentation, e.g. CC BY'

        class_option :bower_directory, default: Middleman::Presentation.config.bower_directory, desc: 'Directory for bower components in "source"-directory'
        class_option :author, default: Middleman::Presentation.config.author, desc: 'Author of presentation'
        class_option :description, desc: 'Description for presentation'
        class_option :subtitle, desc: 'Subtitle of presentation'
        class_option :homepage, default: Middleman::Presentation.config.homepage, desc: 'Homepage of company and/or speaker'
        class_option :company, default: Middleman::Presentation.config.company, desc: 'Company or employer or organization of speaker'
        class_option :location, default: Middleman::Presentation.config.location, desc: 'Location where the presentation take place'
        class_option :audience, default: Middleman::Presentation.config.audience, desc: 'Audience of presentation'

        class_option :phone_number, default: Middleman::Presentation.config.phone_number, desc: 'Phone number to contact speaker'
        class_option :email_address, default: Middleman::Presentation.config.email_address, desc: 'Email address to contact speaker'
        class_option :github_url, default: Middleman::Presentation.config.github_url, desc: 'Url to Github account of speaker'

        class_option :activate_controls, type: :boolean, default: Middleman::Presentation.config.activate_controls, desc: 'Activate controls in reveal.js'
        class_option :activate_progress, type: :boolean, default: Middleman::Presentation.config.activate_progress, desc: 'Activate progress in reveal.js'
        class_option :activate_history, type: :boolean, default: Middleman::Presentation.config.activate_history, desc: 'Activate history in reveal.js'
        class_option :activate_center, type: :boolean, default: Middleman::Presentation.config.activate_center, desc: 'Activate center in reveal.js'
        class_option :activate_slide_number, type: :boolean, default: Middleman::Presentation.config.activate_slide_number, desc: 'Activate slide number in reveal.js'

        class_option :default_transition_type, default: Middleman::Presentation.config.default_transition_type, desc: 'Default slide transition. Can be overwridden per slide.'
        class_option :default_transition_speed, default: Middleman::Presentation.config.default_transition_speed, desc: 'Default speed for slide transition. Can be overwridden per slide.'

        class_option :install_assets, type: :boolean, default: Middleman::Presentation.config.install_assets, desc: 'Install assets'
        class_option :initialize_git, type: :boolean, default: Middleman::Presentation.config.initialize_git, desc: 'Initialize git repository'
        class_option :check_for_bower, type: :boolean, default: Middleman::Presentation.config.check_for_bower, desc: 'Check if bower is installed on the system'

        class_option :create_predefined_slides, type: :boolean, default: Middleman::Presentation.config.create_predefined_slides, desc: 'Install predefined slides'

        class_option :language, type: :array, desc: 'Language to use for translatable slide templates, e.g. "de", "en"'
        class_option :version, default: Middleman::Presentation.config.default_version_number, desc: 'Version number for your presentation'

        argument :directory, default: Dir.getwd, desc: 'Directory to create presentation in'
        desc 'Initialize a new presentation in DIR (default: $PWD)'

        def define_root_directory
          @root_directory = File.expand_path directory
        end

        def add_to_source_path
          source_paths << File.expand_path('../../../../templates', __FILE__)
        end

        def initialize_middleman
          run("middleman init --skip-bundle --template empty #{directory}")
          fail Thor::Error, 'Error executing `middleman init`-command. Please fix your setup and run again.' unless $CHILD_STATUS.exitstatus == 0
        end

        def set_language
          language_detector = FeduxOrgStdlib::ShellLanguageDetector.new
          language = language_detector.detect allowed: I18n.available_locales, overwrite: options[:language]

          I18n.default_locale = language.language_code
        end

        def add_frontend_components
          @external_assets = []

          @external_assets << Middleman::Presentation::FrontendComponent.new(name: 'jquery', version: '~1.11', javascripts: %w(dist/jquery))
          @external_assets << Middleman::Presentation::FrontendComponent.new(name: 'reveal.js', version: 'latest', javascripts: %w(lib/js/head.min js/reveal.min))
          @external_assets << Middleman::Presentation::FrontendComponent.new(name: 'lightbox2', github: 'dg-vrnetze/revealjs-lightbox2', javascripts: %w(js/lightbox))
          @external_assets << Middleman::Presentation::FrontendComponent.new(
            name: 'middleman-presentation-theme-common',
            github: 'dg-vrnetze/middleman-presentation-theme-common',
            stylesheets: %w(stylesheets/middleman-presentation-theme-common),
            javascripts: %w(javascripts/middleman-presentation-theme-common)
          )

          @external_assets.concat Middleman::Presentation::FrontendComponent.parse(Middleman::Presentation.config.components)
        end

        def add_theme
          if Middleman::Presentation.config.theme.blank?
            @external_assets << Middleman::Presentation::FrontendComponent.new(
              name: 'middleman-presentation-theme-default',
              github: 'maxmeyer/middleman-presentation-theme-default',
              stylesheets: %w(stylesheets/middleman-presentation-theme-default)
            )
          else
            @external_assets.concat Middleman::Presentation::FrontendComponent.parse(Middleman::Presentation.config.theme)
          end
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
        end

        def create_middleman_data_files
          template 'data/metadata.yml.tt', File.join(data_directory, 'metadata.yml')
          template 'data/config.yml.tt', File.join(data_directory, 'config.yml')
        end

        def create_bower_configuration_files
          template '.bowerrc.tt', File.join(root_directory, '.bowerrc')
          template 'bower.json.tt', File.join(root_directory, 'bower.json')
        end

        def create_rake_file
          template 'Rakefile', File.join(root_directory, 'Rakefile')
        end

        def create_slides_ignore_file
          create_file File.join(root_directory, '.slidesignore'), "# empty\n"
        end

        def add_gems_to_gem_file
          if ENV['MM_ENV'] == 'development'
            append_to_file File.join(root_directory, 'Gemfile'), <<-EOS.strip_heredoc

            gem 'middleman-presentation', path: '#{File.expand_path('../../../../', __FILE__)}

            EOS
          else
            append_to_file File.join(root_directory, 'Gemfile'), <<-EOS.strip_heredoc

            gem 'middleman-presentation'

            EOS
          end

          append_to_file File.join(root_directory, 'Gemfile'), <<-EOS.strip_heredoc

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

        def add_configuration_for_middleman_presentation
          append_to_file File.join(root_directory, 'config.rb'), <<-EOS.strip_heredoc

          activate :presentation

          set :markdown_engine, :kramdown
          set :markdown, parse_block_html: true

          bower_directory = '#{@bower_directory}'

          if respond_to?(:sprockets) && sprockets.respond_to?(:import_asset)
            sprockets.append_path File.join(root, bower_directory)

            patterns = [
              '.png',  '.gif', '.jpg', '.jpeg', '.svg', # Images
              '.eot',  '.otf', '.svc', '.woff', '.ttf', # Fonts
              '.js',                                    # Javascript
            ].map { |e| File.join(bower_directory, '**', "*\#{e}") }

            require 'rake/file_list'

            list = Rake::FileList.new(*patterns) do |l|
              l.exclude(/src/)
              l.exclude(/test/)
              l.exclude(/demo/)
              l.exclude { |f| !File.file? f }
            end

            list.each do |f|
              sprockets.import_asset Pathname.new(f).relative_path_from(Pathname.new(bower_directory))
            end

            Rake::FileList.new(File.join('vendor/assets/components', '**', 'notes.html' )).each do |f|
              sprockets.import_asset(Pathname.new(f).relative_path_from(Pathname.new(bower_directory))) { |local_path| Pathname.new('javascripts') + local_path }
            end

            Rake::FileList.new(File.join('vendor/assets/components', '**', 'pdf.css' )).each do |f|
              sprockets.import_asset(Pathname.new(f).relative_path_from(Pathname.new(bower_directory))) { |local_path| Pathname.new('stylesheets') + local_path }
            end
          end
          EOS
        end

        def add_patterns_to_gitignore
          append_to_file File.join(root_directory, '.gitignore'), <<-EOS.strip_heredoc
          *.zip
          *.tar.gz
          tmp/
          EOS
        end

        def create_application_asset_files
          template 'source/stylesheets/application.scss.tt', File.join(middleman_source_directory, 'stylesheets', 'application.scss')
          template 'source/javascripts/application.js.tt', File.join(middleman_source_directory, 'javascripts', 'application.js')
        end

        def create_image_directory
          empty_directory File.join(middleman_source_directory, 'images')
        end

        def create_presentation_layout
          copy_file 'source/layout.erb', File.join(middleman_source_directory, 'layout.erb')
          copy_file 'source/index.html.erb', File.join(middleman_source_directory, 'index.html.erb')
        end

        def create_default_slides
          return unless options[:create_predefined_slides]

          PredefinedSlideTemplateDirectory.new(working_directory: root_directory).template_files.each do |file|
            template file, File.join(slides_directory, File.basename(file, '.tt'))
          end
        end

        def create_default_license_file_to_presentation
          copy_file 'LICENSE.presentation', File.join(root_directory, 'LICENSE.presentation')
        end

        def create_helper_scripts
          %w(start bootstrap slide presentation build export).each do |s|
            copy_file File.join('script', s), File.join(root_directory, 'script', s)
            chmod File.join(root_directory, 'script', s), 0755
          end
        end

        def install_external_assets
          inside directory do
            message = format('`bower`-command cannot be found in PATH "%s". Please make sure it is installed and PATH includes the directory where is stored.', ENV['PATH'])
            fail Thor::Error, message if options[:check_for_bower] && File.which('bower').blank?

            result = run('bower update', capture: true) if options[:install_assets] == true
            fail Thor::Error, "Error executing `bower`-command. Please fix your setup and run again:\n#{result}" unless $CHILD_STATUS.exitstatus == 0
          end
        end

        def install_gems
          inside directory do
            Bundler.with_clean_env do
              result = run('bundle install', capture: true) if options[:install_assets] == true
              fail Thor::Error, "Error executing `bundle`-command. Please fix your setup and run again:\n#{result}" unless $CHILD_STATUS.exitstatus == 0
            end
          end
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
          attr_reader :root_directory

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
