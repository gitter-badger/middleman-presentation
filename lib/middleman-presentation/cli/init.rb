# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'presentation init' command for the middleman CLI.
      class Init < Thor
        include Thor::Actions

        desc 'system ', 'Initialize system for use of middleman-presentation'
        option :configuration_file, default: Middleman::Presentation.config.preferred_configuration_file, desc: 'Path to configuration file'
        option :force, type: :boolean, desc: 'Force creation of config file'
        def appplication
          source_paths << File.expand_path('../../../../templates', __FILE__)

          @version = Middleman::Presentation::VERSION
          @config = Middleman::Presentation.config

          opts = options.dup.deep_symbolize_keys
          template 'config.yaml.tt', opts.delete(:configuration_file), **opts
        end

        option :speaker, required: true, default: Middleman::Presentation.config.speaker, desc: 'Name of speaker'
        option :title, required: true, desc: 'Title of presentation'
        option :date, required: true, default: Time.now.strftime('%d.%m.%Y'), desc: 'Date of presentation'
        option :license, required: true, default: Middleman::Presentation.config.license, desc: 'License of the presentation, e.g. CC BY'

        option :bower_directory, default: Middleman::Presentation.config.bower_directory, desc: 'Directory for bower components in "source"-directory'
        option :author, default: Middleman::Presentation.config.author, desc: 'Author of presentation'
        option :description, desc: 'Description for presentation'
        option :subtitle, desc: 'Subtitle of presentation'
        option :homepage, default: Middleman::Presentation.config.homepage, desc: 'Homepage of company and/or speaker'
        option :company, default: Middleman::Presentation.config.company, desc: 'Company or employer or organization of speaker'
        option :location, default: Middleman::Presentation.config.location, desc: 'Location where the presentation take place'
        option :audience, default: Middleman::Presentation.config.audience, desc: 'Audience of presentation'

        option :phone_number, default: Middleman::Presentation.config.phone_number, desc: 'Phone number to contact speaker'
        option :email_address, default: Middleman::Presentation.config.email_address, desc: 'Email address to contact speaker'
        option :github_url, default: Middleman::Presentation.config.github_url, desc: 'Url to Github account of speaker'

        option :activate_controls, type: :boolean, default: Middleman::Presentation.config.activate_controls, desc: 'Activate controls in reveal.js'
        option :activate_progress, type: :boolean, default: Middleman::Presentation.config.activate_progress, desc: 'Activate progress in reveal.js'
        option :activate_history, type: :boolean, default: Middleman::Presentation.config.activate_history, desc: 'Activate history in reveal.js'
        option :activate_center, type: :boolean, default: Middleman::Presentation.config.activate_center, desc: 'Activate center in reveal.js'
        option :activate_slide_number, type: :boolean, default: Middleman::Presentation.config.activate_slide_number, desc: 'Activate slide number in reveal.js'

        option :default_transition_type, default: Middleman::Presentation.config.default_transition_type, desc: 'Default slide transition. Can be overwridden per slide.'
        option :default_transition_speed, default: Middleman::Presentation.config.default_transition_speed, desc: 'Default speed for slide transition. Can be overwridden per slide.'

        option :install_assets, type: :boolean, default: Middleman::Presentation.config.install_assets, desc: 'Install assets'
        option :initialize_git, type: :boolean, default: Middleman::Presentation.config.initialize_git, desc: 'Initialize git repository'
        option :check_for_bower, type: :boolean, default: Middleman::Presentation.config.check_for_bower, desc: 'Check if bower is installed on the system'

        option :install_contact_slide, type: :boolean, default: Middleman::Presentation.config.install_contact_slide, desc: 'Install contact slide'
        option :install_question_slide, type: :boolean, default: Middleman::Presentation.config.install_question_slide, desc: 'Install question slide'
        option :install_end_slide, type: :boolean, default: Middleman::Presentation.config.install_end_slide, desc: 'Install end slide'

        option :language, type: :array, desc: 'Language to use for translatable slide templates, e.g. "de", "en"'
        option :version, default: Middleman::Presentation.config.default_version_number, desc: 'Version number for your presentation'

        desc 'presentation [DIR]', 'Initialize a new presentation in DIR (default: $PWD)'
        def presentation(directory = Dir.getwd)
          source_paths << File.expand_path('../../../../templates', __FILE__)

          root_directory   = File.expand_path directory
          data_directory   = File.join root_directory, 'data'
          middleman_source_directory = File.join root_directory, 'source'
          slides_directory = File.join middleman_source_directory, Middleman::Presentation.config.slides_directory

          Dir.chdir root_directory

          run("middleman init --skip-bundle --template empty .")
          fail Thor::Error, 'Error executing `middleman init`-command. Please fix your setup and run again.' if $CHILD_STATUS && !$CHILD_STATUS.exitstatus == 0

          language_detector = FeduxOrgStdlib::ShellLanguageDetector.new
          language = language_detector.detect allowed: I18n.available_locales, overwrite: options[:language]

          I18n.default_locale = language.language_code

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

          if Middleman::Presentation.config.theme.blank?
            @external_assets << Middleman::Presentation::FrontendComponent.new(
              name: 'middleman-presentation-theme-default',
              github: 'maxmeyer/middleman-presentation-theme-default',
              stylesheets: %w(stylesheets/middleman-presentation-theme-default)
            )
          else
            @external_assets.concat Middleman::Presentation::FrontendComponent.parse(Middleman::Presentation.config.theme)
          end

          @revealjs_config = {}
          @revealjs_config[:controls]                 = options[:activate_controls]
          @revealjs_config[:progress]                 = options[:activate_progress]
          @revealjs_config[:history]                  = options[:activate_history]
          @revealjs_config[:center]                   = options[:activate_center]
          @revealjs_config[:slide_number]             = options[:activate_slide_number]
          @revealjs_config[:default_transition_type]  = options[:default_transition_type]
          @revealjs_config[:default_transition_speed] = options[:default_transition_speed]

          @links_for_stylesheets = []
          @links_for_javascripts = []

          template 'data/metadata.yml.tt', File.join(data_directory, 'metadata.yml')
          template 'data/config.yml.tt', File.join(data_directory, 'config.yml')
          template '.bowerrc.tt', File.join(root_directory, '.bowerrc')
          template 'bower.json.tt', File.join(root_directory, 'bower.json')
          template 'Rakefile', File.join(root_directory, 'Rakefile')

          create_file '.slidesignore', "# empty\n"

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

          append_to_file File.join(root_directory, '.gitignore'), <<-EOS.strip_heredoc
          *.zip
          *.tar.gz
          tmp/
          EOS

          template 'source/stylesheets/application.scss.tt', File.join(middleman_source_directory, 'stylesheets', 'application.scss')
          template 'source/javascripts/application.js.tt', File.join(middleman_source_directory, 'javascripts', 'application.js')

          empty_directory 'source/images'

          copy_file 'source/layout.erb', File.join(middleman_source_directory, 'layout.erb')
          template 'source/slides/00.html.erb.tt', File.join(slides_directory, '00.html.erb')
          template 'source/slides/999980.html.erb', File.join(slides_directory, '999980.html.erb') if options[:install_question_slide]
          template 'source/slides/999981.html.erb', File.join(slides_directory, '999981.html.erb') if options[:install_contact_slide]
          template 'source/slides/999982.html.erb', File.join(slides_directory, '999982.html.erb') if options[:install_end_slide]

          copy_file 'source/index.html.erb', File.join(middleman_source_directory, 'index.html.erb')
          copy_file 'LICENSE.presentation', File.join(root_directory, 'LICENSE.presentation')

          %w(start bootstrap slide presentation build).each do |s|
            copy_file File.join('script', s), File.join(root_directory, 'script', s)
            chmod File.join(root_directory, 'script', s), 0755
          end

          message = format('`bower`-command cannot be found in PATH "%s". Please make sure it is installed and PATH includes the directory where is stored.', ENV['PATH'])
          fail Thor::Error, message if options[:check_for_bower] && File.which('bower').blank?

          result = run('bower update', capture: true) if options[:install_assets] == true
          fail Thor::Error, "Error executing `bower`-command. Please fix your setup and run again:\n#{result}" if $CHILD_STATUS && !$CHILD_STATUS.exitstatus == 0

          result = run('bundle install', capture: true) if options[:install_assets] == true
          fail Thor::Error, "Error executing `bundle`-command. Please fix your setup and run again:\n#{result}" if $CHILD_STATUS && !$CHILD_STATUS.exitstatus == 0

          if options[:initialize_git]
            run 'git init'
            run 'git add -A .'
            run 'git commit -m Init'
          end
        end

        default_command :presentation
      end
    end
  end
end
