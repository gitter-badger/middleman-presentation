# encoding: utf-8
module Middleman
  module Presentation
    # End slide template
    class EndSlideTemplate < FeduxOrgStdlib::FileTemplate
      def proposed_file_name
        '999982.html.erb'
      end

      def fallback_template_directory
        File.expand_path('../../../../templates/predefined_slides', __FILE__)
      end
    end
  end
end
