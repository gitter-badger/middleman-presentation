# encoding, utf-8
module Middleman
  module Presentation
    # Configuration for presentation extension
    class PresentationConfig < FeduxOrgStdlib::AppConfig
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

      option :edit, false
      option :editor_command, process_environment.fetch('EDITOR', 'vim')
      option :error_on_duplicates, true

      option :force_create_presentation, false
      option :debug_mode, false
    end
  end
end
