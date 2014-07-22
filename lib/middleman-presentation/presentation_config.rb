# encoding, utf-8
module Middleman
  module Presentation
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
      option :template, {}
      option :components, []
      option :activate_controls, true
      option :activate_progress, true
      option :activate_history, true
      option :activate_center, true
      option :default_transition_type, 'linear'
      option :default_transition_speed, 'default'
      option :install_assets, true
      option :initialize_git, true
      option :clear_source, true
      option :use_logo, true
      option :install_contact_slide, true
      option :install_question_slide, true
      option :install_end_slide, true
      option :language, :de

      option :edit, false
      option :editor_client, process_environment.fetch('EDITOR', 'vim')
      option :editor_client_parameters, nil
      option :editor_server, process_environment.fetch('EDITOR', 'vim')
      option :editor_server_parameters, nil
    end
  end
end
