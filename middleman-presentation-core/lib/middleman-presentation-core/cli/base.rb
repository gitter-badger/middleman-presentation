# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Base cli class
      class Base < Thor
        def self.exit_on_failure?
          true
        end

        def self.subcommand_help(_cmd)
          desc 'help [COMMAND]', Middleman::Presentation.t('views.application.help')

          class_eval "
                                def help(command = nil, subcommand = true); super; end
          "
        end

        desc 'help [COMMAND]', Middleman::Presentation.t('views.application.help')
        def help(*args)
          super
        end

        no_commands do
          def enable_debug_mode
            Middleman::Presentation.enable_debug_mode if options[:debug_mode] == true
          end

          def asset_loader
            @asset_loader ||= Middleman::Presentation::AssetsLoader.new(root_directory: Middleman::Presentation.bower_directory)
          end

          def load_assets
            asset_loader.load_at_presentation_runtime
          end
        end
      end
    end
  end
end
