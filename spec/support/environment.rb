# encoding: utf-8
require 'fedux_org_stdlib/environment'

module Middleman
  module Presentation
    # Spec Helpers
    module SpecHelper
      # Helpers for environment
      module Environment
        include FeduxOrgStdlib::Environment
      end
    end
  end
end

RSpec.configure do |c|
  c.include Middleman::Presentation::SpecHelper::Environment
end
