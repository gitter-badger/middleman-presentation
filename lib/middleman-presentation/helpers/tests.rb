# encoding: utf-8
module Middleman
  module Presentation
    module Helpers
      module Tests
        def ci?
          ENV.key?('CI') || ENV.key?('TRAVIS')
        end
      end
    end
  end
end
