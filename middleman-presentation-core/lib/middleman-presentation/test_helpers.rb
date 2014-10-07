# encoding: utf-8
module Middleman
  module Presentation
    # Test helpers
    module TestHelpers
      # Helpers for tests
      def ci?
        ENV.key?('CI') || ENV.key?('TRAVIS')
      end
    end
  end
end
