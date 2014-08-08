# encoding: utf-8

# Test helpers
require 'middleman-presentation/helpers/tests'

module Middleman
  module Presentation
    # Spec Helpers
    module SpecHelper
      # Helpers for ci
      module Ci
        include Middleman::Presentation::Helpers::Tests
      end
    end
  end
end

RSpec.configure do |c|
  c.include Middleman::Presentation::SpecHelper::Ci
end
