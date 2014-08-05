# encoding, utf-8
module Middleman
  module Presentation
    # Configuration for presentation extension
    class PresentationConfig < FeduxOrgStdlib::AppConfig
      option :speaker, process_environment.fetch('USER')
      option :license, 'CC BY 4.0'
      option :bower_directory, 'vendor/assets/components'
      option :author,  process_environment.fetch('USER')
      option :description,  nil
      option :homepage,  nil
      option :company,  nil
      option :location,  nil
      option :audience,  nil
      option :phone_number,  nil
      option :email_address,  nil
      option :github_url,  nil
      option :theme, {}
      option :components, []
      option :activate_controls, true
      option :activate_progress, true
      option :activate_history, true
      option :activate_center, true
      option :activate_slide_number, true
      option :default_transition_type, 'linear'
      option :default_transition_speed, 'default'
      option :install_assets, true
      option :initialize_git, true
      option :clear_source, true
      option :install_contact_slide, true
      option :install_question_slide, true
      option :install_end_slide, true
      option :language, :de
      option :default_version_number, 'v0.0.1'

      option :slides_directory, 'slides'
      option :slides_ignore_file, '.slidesignore'

      option :create_stylesheets_directory, true
      option :create_javascripts_directory, true
      option :create_images_directory, true
      option :theme_prefix, 'middleman-presentation-theme'

      option :edit, false
      option :editor_command, process_environment.fetch('EDITOR', 'vim')
      option :error_on_duplicates, true
    end
  end
end
