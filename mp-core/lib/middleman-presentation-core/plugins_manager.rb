# encoding: utf-8
module Middleman
  module Presentation
    class PluginsManager < FeduxOrgStdlib::GemPlugins::PluginManager
      def __plugin_prefix
        name = if self.class.name.deconstantize.blank?
                 self.class.name
               else
                 self.class.name.deconstantize
               end

        prefixes = []
        prefixes << Regexp.new("#{name.underscore.gsub(/\//, '-')}-")
        prefixes << Regexp.new('mp-')

        prefixes.inject(Regexp.new(SecureRandom.hex)) { |a, e| Regexp.union(a, e) }
      end
    end
  end
end
