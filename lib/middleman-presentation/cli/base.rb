# encoding: utf-8
module Middleman
  module Presentation
    class Base < Thor
      def self.subcommand_help(cmd)
        desc "help [COMMAND]", Middleman::Presentation.t('views.application.help')

        class_eval "
                                def help(command = nil, subcommand = true); super; end
        "
      end

      desc "help [COMMAND]", Middleman::Presentation.t('views.application.help')
      def help(*args)
        super
      end
    end
  end
end
