# encoding: utf-8
require 'fedux_org_stdlib/filesystem'

module Middleman
  module Revealjs
    module SpecHelper
      module Filesystem
        include FeduxOrgStdlib::Filesystem

        def root_directory
          ::File.expand_path('../../../', __FILE__)
        end
      end
    end
  end
end

RSpec.configure do |c|
  c.include Middleman::Revealjs::SpecHelper::Filesystem
  c.before(:each) { cleanup_working_directory }
end
