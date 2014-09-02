# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Base group cli class
      class BaseGroup < Thor::Group
        def self.exit_on_failure?
          true
        end
      end
    end
  end
end
