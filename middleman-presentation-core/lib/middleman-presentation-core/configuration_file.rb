# encoding: utf-8
module Middleman
  module Presentation
    class ConfigurationFile
      extend Forwardable

      def_delegators :@file_finder, :directory, :file

      def initialize(raise_error: true)
        @file_finder = FeduxOrgStdlib::RecursiveFileFinder.new(file_name: 'config.rb', raise_error: raise_error)
      end
    end
  end
end
