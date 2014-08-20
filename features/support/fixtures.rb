# encoding: utf-8
module Middleman
  module Presentation
    module FeatureHelper
      # Helper for fixtures
      module Fixtures
        def fixtures_manager
          @fixtures_manager ||= FixturesManager.new

          @fixtures_manager.load_fixtures(File.join(Middleman::Presentation.root_path, 'fixtures'))

          @fixtures_manager
        end
      end
    end
  end
end

World(Middleman::Presentation::FeatureHelper::Fixtures)
