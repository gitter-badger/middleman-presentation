# encoding: utf-8
module Middleman
  module Presentation
    # Start slide template
    class StartSlideTemplate < FeduxOrgStdlib::FileTemplate
      def proposed_file_name
        '00.html.erb'
      end

      def fallback_template_directory
        File.expand_path('../../../../templates/predefined_slides', __FILE__)
      end
    end
  end
end
