# encoding, utf-8
module Middleman
  module Presentation
    # Configuration for presentation extension
    class ApplicationConfig < FeduxOrgStdlib::AppConfig
      option :title, nil
      option :subtitle, nil
      option :project_id, nil
      option :version, nil

      option :date , Time.now.strftime('%Y-%m-%d %H:%M:%S')
      option :speaker, process_environment.fetch('USER')
      option :license, 'CC BY 4.0'
      option :bower_directory, 'vendor/assets/components'
      option :author, `git config user.name`.strip.blank? ? process_environment.fetch('USER') : `git config user.name`.strip
      option :email, `git config user.email`.strip.blank? ? 'noemail@example.org' : `git config user.email`.strip
      option :description,  nil
      option :homepage,  nil
      option :company,  nil
      option :location,  nil
      option :audience,  nil
      option :phone_number,  nil
      option :email_address,  nil
      option :github_url,  nil

      option :theme, name: 'middleman-presentation-theme-default',
                     github: 'maxmeyer/middleman-presentation-theme-default',
                     importable_files: [
                       %r{stylesheets/middleman-presentation-theme-default.scss$}
                     ],
                     loadable_files: [
                       /.*\.png$/
                     ]

      option :plugin_prefix, 'middleman-presentation'

      option :components, []
      option :activate_controls, true
      option :activate_progress, true
      option :activate_history, true
      option :activate_center, true
      option :activate_slide_number, true
      option :default_transition_type, 'linear'
      option :default_transition_speed, 'default'
      option :view_port, %w(960 700 0.1)
      option :install_assets, true
      option :initialize_git, true
      option :check_for_bower, true
      option :clear_source, true
      option :create_predefined_slides, true
      option :presentation_language, nil
      option :cli_language, nil
      option :default_version_number, 'v0.0.1'

      option :plugins, []

      option :slides_directory, 'slides'
      option :slides_ignore_file, '.slidesignore'

      option :create_stylesheets_directory, true
      option :create_javascripts_directory, true
      option :create_images_directory, true
      option :theme_prefix, 'middleman-presentation-theme'

      option :edit_created_slide, false
      option :edit_changed_slide, false
      option :editor_command, process_environment.fetch('EDITOR', 'vim')
      option :error_on_duplicates, true

      option :force_create_presentation, false
      option :debug_mode, false
      option :exportable_options, %w(
        bower_directory
        view_port
        activate_progress
        activeate_history
        activate_slide_number
        activate_center
        default_transition_type
        default_transition_speed
        speaker
        title
        date
        author
        description
        subtitle
        homepage
        company
        license
        location
        audience
        email_address
        phone_number
        github_url
        project_id
        version
      )

      option :loadable_assets_for_installed_components, [
        /\.png$/,
        /\.gif$/,
        /\.jpg$/,
        /\.jpeg$/,
        /\.svg$/,
        /\.webp$/,
        /\.eot$/,
        /\.otf$/,
        /\.svc$/,
        /\.woff$/,
        /\.ttf$/
      ]

      private

      def _application_name
        'middleman-presentation'
      end

      def _config_name
        'application'
      end

      def _allowed_config_file_paths
        [
          ::File.expand_path(::File.join('~', '.config', _application_name, _config_file)),
          ::File.expand_path(::File.join('~', format('.%s', _application_name), _config_file)),
          ::File.expand_path(::File.join('~', format('.%s%s', _application_name, _config_file_suffix))),
          ::File.expand_path(::File.join('~', format('.%src', _application_name))),
          ::File.expand_path(::File.join('/etc', _application_name, _config_file)),
          ::File.expand_path(::File.join(working_directory, format('%s%s', _application_name, _config_file_suffix)))
        ]
      end
    end
  end
end
