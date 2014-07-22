# encoding: utf-8
module Middleman
  module Cli
    # This class provides an 'presentation' command for the middleman CLI.
    class Presentation < Thor
      include Thor::Actions

      check_unknown_options!

      namespace :presentation

      def self.source_root
        ENV['MM_ROOT']
      end

      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
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

      option :use_open_sans, type: :boolean, default: Middleman::Presentation.config.use_open_sans, desc: 'Include open-sans'
      option :use_jquery, type: :boolean, default: Middleman::Presentation.config.use_jquery, desc: 'Include jquery'
      option :use_lightbox, type: :boolean, default: Middleman::Presentation.config.use_lightbox, desc: 'Include lightbox 2'
      option :use_fedux_org_template, type: :boolean, default: Middleman::Presentation.config.use_fedux_org_template, desc: 'Use template of fedux_org'

      option :activate_controls, type: :boolean, default: Middleman::Presentation.config.activate_controls, desc: 'Activate controls in reveal.js'
      option :activate_progress, type: :boolean, default: Middleman::Presentation.config.activate_progress, desc: 'Activate progress in reveal.js'
      option :activate_history, type: :boolean, default: Middleman::Presentation.config.activate_history, desc: 'Activate history in reveal.js'
      option :activate_center, type: :boolean, default: Middleman::Presentation.config.activate_center, desc: 'Activate center in reveal.js'

      option :default_transition_type, default: Middleman::Presentation.config.default_transition_type, desc: 'Default slide transition. Can be overwridden per slide.'
      option :default_transition_speed, default: Middleman::Presentation.config.default_transition_speed, desc: 'Default speed for slide transition. Can be overwridden per slide.'

      option :install_assets, type: :boolean, default: Middleman::Presentation.config.install_assets, desc: 'Install assets'
      option :initialize_git, type: :boolean, default: Middleman::Presentation.config.initialize_git, desc: 'Initialize git repository'

      option :clear_source, type: :boolean, default: Middleman::Presentation.config.clear_source, desc: 'Remove already existing source directory'

      option :use_logo, type: :boolean, default: Middleman::Presentation.config.use_logo, desc: 'Use logo on first slide'
      option :install_contact_slide, type: :boolean, default: Middleman::Presentation.config.install_contact_slide, desc: 'Install contact slide'
      option :install_question_slide, type: :boolean, default: Middleman::Presentation.config.install_question_slide, desc: 'Install question slide'
      option :install_end_slide, type: :boolean, default: Middleman::Presentation.config.install_end_slide, desc: 'Install end slide'

      option :language, default: Middleman::Presentation.config.language, desc: 'Language to use for translatable slide templates'

      desc 'presentation ', 'Initialize a new presentation'
      def presentation
        source_paths << File.expand_path('../../../../templates', __FILE__)

        shared_instance = ::Middleman::Application.server.inst

        I18n.default_locale = options[:language].to_sym

        # This only exists when the config.rb sets it!
        if shared_instance.extensions.key? :presentation
          presentation_inst = shared_instance.extensions[:presentation]

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

          @external_assets = {}
          @external_assets["reveal.js"] = "latest"
          @external_assets["jquery"] = "~1.11.0"   if options[:use_jquery] == true
          @external_assets["open-sans"] = "https://github.com/bungeshea/open-sans.git" if options[:use_open_sans] == true
          @external_assets["lightbox2"] = "https://github.com/dg-vrnetze/revealjs-lightbox2" if options[:use_lightbox] == true
          @external_assets["reveal.js-template-fedux_org"] = "https://github.com/maxmeyer/reveal.js-template-fedux_org.git" if options[:use_fedux_org_template] == true

          @revealjs_config = {}
          @revealjs_config[:controls] = options[:activate_controls]
          @revealjs_config[:progress] = options[:activate_progress]
          @revealjs_config[:history]  = options[:activate_history]
          @revealjs_config[:center]   = options[:activate_center]
          @revealjs_config[:default_transition_type]   = options[:default_transition_type]
          @revealjs_config[:default_transition_speed]   = options[:default_transition_speed]

          @links_for_stylesheets = []
          @links_for_javascripts = []

          if options[:use_fedux_org_template] == true
            @links_for_stylesheets << 'reveal.js-template-fedux_org/scss/fedux_org'
            @links_for_javascripts << 'reveal.js-template-fedux_org/js/fedux_org'
          end

          if options[:use_jquery] == true    
            @links_for_javascripts << 'jquery/dist/jquery'
          end
          if options[:use_open_sans] == true 
            @links_for_stylesheets << 'open-sans/scss/open-sans'
          end
          if options[:use_lightbox] == true  
            @links_for_javascripts << 'lightbox2/js/lightbox'
          end

          slides_directory = File.join shared_instance.source_dir, presentation_inst.options.slides_directory
          data_directory = File.join shared_instance.root, 'data'

          remove_dir 'source' if options[:clear_source]

          template 'data/metadata.yml.tt', File.join(data_directory, 'metadata.yml')
          template 'data/config.yml.tt', File.join(data_directory, 'config.yml')
          template '.bowerrc.tt', File.join(shared_instance.root, '.bowerrc')
          template 'bower.json.tt', File.join(shared_instance.root, 'bower.json')

          append_to_file File.join(shared_instance.root, 'config.rb'), <<-EOS.strip_heredoc

          ready do
            sprockets.append_path File.join(root, 'source/#{@bower_directory}')
          end

          set :markdown_engine, :redcarpet
          set :redcarpet, fenced_code_blocks: true, autolink: true
          EOS

          append_to_file File.join(shared_instance.root, 'Gemfile'), <<-EOS.strip_heredoc

          group :development, :test do
            gem 'pry'
            gem 'byebug'
            gem 'pry-byebug'
          end

          gem 'redcarpet'
          gem 'github-markup'
          gem 'liquid'
          gem 'rake'
          EOS

          append_to_file File.join(shared_instance.root, '.gitignore'), <<-EOS.strip_heredoc
          *.zip
          *.tar.gz
          tmp/
          EOS

          template 'source/stylesheets/application.scss.tt', File.join(shared_instance.source_dir, 'stylesheets', 'application.scss')
          template 'source/javascripts/application.js.tt', File.join(shared_instance.source_dir, 'javascripts', 'application.js')

          empty_directory 'source/images'

          copy_file 'source/layout.erb', File.join(shared_instance.source_dir, 'layout.erb')
          template 'source/slides/00.html.erb.tt', File.join(slides_directory, '00.html.erb')
          template 'source/slides/999980.html.erb', File.join(slides_directory, '999980.html.erb') if options[:install_question_slide]
          template 'source/slides/999981.html.erb', File.join(slides_directory, '999981.html.erb') if options[:install_contact_slide]
          template 'source/slides/999982.html.erb', File.join(slides_directory, '999982.html.erb') if options[:install_end_slide]

          copy_file 'source/index.html.erb', File.join(shared_instance.source_dir, 'index.html.erb')
          copy_file 'LICENSE.presentation', File.join(shared_instance.root, 'LICENSE.presentation')

          %w{ start bootstrap }.each do |s|
            copy_file File.join('script', s), File.join(shared_instance.root, 'script', s)
            chmod File.join(shared_instance.root, 'script', s), 0755
          end

          run 'bower install' if options[:install_assets] == true

          if options[:initialize_git]
            run 'git init'
            run 'git add -A .'
          end
        else
          raise Thor::Error.new 'You need to activate the presentation extension in config.rb before you can create a slide.'
        end
      end
    end
  end
end
