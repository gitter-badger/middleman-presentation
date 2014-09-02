# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Build presentation
      class Build < Base
        register BuildPresentation, 'presentation', 'presentation', 'Build presentation'
      end
    end
  end
end
