# encoding: utf-8
module Middleman
  module Presentation
    class Plugin < FeduxOrgStdlib::GemPlugins::Plugin
      def variants
        return @__v if @__v

        @__v = []
        @__v << gem_name.sub(/mp-/, 'middleman-presentation-')
        @__v << gem_name
        @__v << gem_name.gsub(/-/, '/')
        @__v << prefix.source.sub(/-$/, '') if prefix

        @__v
      end

    end
  end
end
