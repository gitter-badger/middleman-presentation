# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'presentation init' command for the middleman CLI.
      class Show < Thor
        include Thor::Actions

        desc 'support_information', 'Collect information for support'
        def support_information
          puts FeduxOrgStdlib::SupportInformation.new.to_s
        end
      end
    end
  end
end
