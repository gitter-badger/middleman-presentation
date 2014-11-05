# encoding, utf-8
module Middleman
  module Presentation
    # Configuration for presentation extension
    class ApplicationConfig < FeduxOrgStdlib::AppConfig
      option :title, nil
      option :subtitle, nil
      option :project_id, nil
      option :version, nil

      option :date, Time.now.strftime('%Y-%m-%d %H:%M:%S')
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

      option :width, 960
      option :height, 700
      option :margin, 0.1
      option :min_scale, 0.2
      option :max_scale, 1.0
      option :activate_center, true
      option :activate_controls, true
      option :activate_embedded, false
      option :activate_fragments, true
      option :activate_history, true
      option :activate_keyboard, true
      option :activate_loop, false
      option :activate_mouse_wheel, true
      option :activate_overview, true
      option :activate_progress, true
      option :activate_rtl, false
      option :activate_slide_number, true
      option :activate_touch, true
      option :auto_slide, 0
      option :auto_slide_stoppable, true
      option :default_background_transition, 'default'
      option :default_transition_speed, 'default'
      option :default_transition_type, 'linear'
      option :hide_address_bar, true
      option :parallax_background_image, ''
      option :parallax_background_size, ''
      option :preview_links, false
      option :view_distance, 3

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
        activate_center
        activate_controls
        activate_embedded
        activate_fragments
        activate_history
        activate_keyboard
        activate_loop
        activate_mouse_wheel
        activate_overview
        activate_progress
        activate_rtl
        activate_slide_number
        activate_touch
        activeate_history
        audience
        author
        auto_slide
        auto_slide_stoppable
        bower_directory
        company
        date
        default_background_transition
        default_transition_speed
        default_transition_type
        description
        email_address
        github_url
        height
        hide_address_bar
        homepage
        license
        location
        margin
        max_scale
        min_scale
        parallax_background_image
        parallax_background_size
        phone_number
        preview_links
        project_id
        speaker
        subtitle
        title
        version
        view_distance
        width
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

      option :sources_directory, 'source'
      option :images_directory, 'images'
      option :scripts_directory, 'javascripts'
      option :stylesheets_directory, 'stylesheets'
      option :fonts_directory, 'fonts'
      option :build_directory, 'build'

      option :minify_assets, false

      option :runtime_environment, ENV['MP_ENV'].to_s.to_sym
      option :use_regex, false

      def preferred_configuration_file
        ::File.expand_path(::File.join('~', '.config', _application_name, _config_file))
      end

      private

      def _application_name
        'middleman-presentation'
      end

      def _config_name
        'application'
      end

      def _allowed_config_file_paths
        [
          ::File.expand_path(::File.join(ConfigurationFile.new(raise_error: false).directory.to_s, format('.%s%s', _application_name, _config_file_suffix))),
          ::File.expand_path(::File.join(ConfigurationFile.new(raise_error: false).directory.to_s, format('%s%s', _application_name, _config_file_suffix))),
          ::File.expand_path(::File.join('~', '.config', _application_name, _config_file)),
          ::File.expand_path(::File.join('~', format('.%s', _application_name), _config_file)),
          ::File.expand_path(::File.join('~', format('.%s%s', _application_name, _config_file_suffix))),
          ::File.expand_path(::File.join('~', format('.%src', _application_name))),
          ::File.expand_path(::File.join('/etc', _application_name, _config_file))
        ]
      end
    end
  end
end
