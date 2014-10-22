# encoding: utf-8
require 'aruba/cucumber'

module Middleman
  module Presentation
    # Spec Helpers
    module FeatureHelper
      # Helpers for aruba
      module Aruba
        def dirs
          @dirs ||= %w(tmp cucumber)
        end
      end
    end
  end
end

World(Middleman::Presentation::FeatureHelper::Aruba)
