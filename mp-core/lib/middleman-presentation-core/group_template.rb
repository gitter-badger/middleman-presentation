# encoding: utf-8
module Middleman
  module Presentation
    # Template for a group of slides
    class GroupTemplate < FeduxOrgStdlib::FileTemplate
      def fallback_template_directory
        File.expand_path('../../../templates/slides', __FILE__)
      end
    end
  end
end
