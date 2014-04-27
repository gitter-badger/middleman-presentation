# encoding: utf-8
require 'fedux_org/stdlib/environment'

module Middleman
  module Revealjs
    module SpecHelper
      module Environment
        include FeduxOrg::Stdlib::Environment
        alias_method :with_environment, :isolated_environment 
      end
    end
  end
end

RSpec.configure do |c|
  c.include Middleman::Revealjs::SpecHelper::Environment
end

