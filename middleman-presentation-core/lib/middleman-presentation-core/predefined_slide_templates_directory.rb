# encoding: utf-8
module Middleman
  module Presentation
    # Predefined slide templates directory
    class PredefinedSlideTemplateDirectory < FeduxOrgStdlib::TemplateDirectory
      def application_name
        'middleman-presentation'
      end

      def fallback_template_directory
        File.expand_path('../../../templates', __FILE__)
      end
    end
  end
end
