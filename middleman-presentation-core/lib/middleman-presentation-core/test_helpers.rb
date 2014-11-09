# encoding: utf-8
module Middleman
  module Presentation
    # Test helpers
    module TestHelpers
      # Helpers for tests
      def ci?
        ENV.key?('CI') || ENV.key?('TRAVIS')
      end

      def temporary_fixture_path(name)
        File.expand_path("../../../tmp/fixtures/#{name}", __FILE__)
      end

      def temporary_fixture_exist?(name)
        File.exist? File.expand_path("../../../tmp/fixtures/#{name}", __FILE__)
      end

      module_function :temporary_fixture_path
    end
  end
end
