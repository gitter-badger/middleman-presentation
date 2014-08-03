# encoding: utf-8
require 'fedux_org_stdlib/environment'

module Middleman
  module Revealjs
    module SpecHelper
      module Environment
        include FeduxOrgStdlib::Environment
      end
    end
  end
end

RSpec.configure do |c|
  c.include Middleman::Revealjs::SpecHelper::Environment
end
