# encoding: utf-8
module Middleman
  module Presentation
    # Erb template for a new slide
    class ErbTemplate < FeduxOrgStdlib::FileTemplate
      def _fallback_template_directory
        File.expand_path('../../../templates/slides', __FILE__)
      end
    end
  end
end
