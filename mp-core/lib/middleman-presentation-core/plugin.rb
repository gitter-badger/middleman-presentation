# encoding: utf-8
module Middleman
  module Presentation
    class Plugin < FeduxOrgStdlib::GemPlugins::Plugin
      def local_variant
        gem_name.sub(/mp-/, 'middleman-presentation-')
      end
    end
  end
end
