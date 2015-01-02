# encoding: utf-8

# Test helpers
require 'middleman-presentation-helpers/test_helpers'

# Spec Helpers
module SpecHelper
  # Helpers for ci
  module Ci
    include Middleman::Presentation::Helpers::Test
  end
end

RSpec.configure do |c|
  c.include SpecHelper::Ci
end
