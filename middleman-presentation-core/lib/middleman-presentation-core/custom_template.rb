# encoding: utf-8
module Middleman
  module Presentation
    # Custom template for a new slide
    class CustomTemplate < FeduxOrgStdlib::FileTemplate
      def application_name
        'middleman-presentation'
      end

      def fallback_template_directory
        File.expand_path('../../../templates/slides', __FILE__)
      end
    end
  end
end
