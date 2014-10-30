# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Base cli class
      class Base < Thor
        include Shared

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
          def load_runtime_assets
            assets_loader.load_at_presentation_runtime
          end
        end
      end
    end
  end
end
