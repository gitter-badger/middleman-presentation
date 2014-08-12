# encoding: utf-8
module Middleman
  module Presentation
    # Contact slide template
    class ContactSlideTemplate < FeduxOrgStdlib::FileTemplate
      def proposed_file_name
        '999981.html.erb'
      end

      def fallback_template_directory
        File.expand_path('../../../../templates/predefined_slides', __FILE__)
      end
    end
  end
end
