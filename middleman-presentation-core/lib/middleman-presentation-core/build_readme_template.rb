# encoding: utf-8
module Middleman
  module Presentation
    # Markdown template to create new slides
    class BuildReadmeTemplate < FeduxOrgStdlib::FileTemplate
      def application_name
        'middleman-presentation'
      end

      def fallback_template_directory
        File.expand_path('../../../templates/', __FILE__)
      end
    end
  end
end
