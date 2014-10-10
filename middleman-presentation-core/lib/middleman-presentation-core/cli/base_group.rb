# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Base group cli class
      class BaseGroup < Thor::Group
        def self.exit_on_failure?
          true
        end

        no_commands do
          def enable_debug_mode
            Middleman::Presentation.enable_debug_mode if options[:debug_mode] == true
          end
        end
      end
    end
  end
end
