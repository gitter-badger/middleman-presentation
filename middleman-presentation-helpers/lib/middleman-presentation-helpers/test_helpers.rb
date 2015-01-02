# encoding: utf-8
require 'fedux_org_stdlib/core_ext/string/characterize'

module Middleman
  module Presentation
    module Helpers
      # Test helpers
      module Test
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

        def create_presentation(name, title, date)
          directory = []
          directory << name
          directory << ('-' + title)
          directory << ('-' + date) if date

          directory = directory.join.characterize

          command = []
          command << "middleman-presentation create presentation #{temporary_fixture_path(directory)}"
          command << "--title #{Shellwords.escape(title)}"
          command << "--date #{Shellwords.escape(date)}" if date

          system(command.join(' ')) unless temporary_fixture_exist?(directory)

          FileUtils.cp_r temporary_fixture_path(directory), absolute_path(name)
        end

        module_function :temporary_fixture_path
      end
    end
  end
end
