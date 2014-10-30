# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      module Shared
        def self.included(base)
          base.extend ClassMethods
        end

        # Enable debug mode
        def enable_debug_mode
          Middleman::Presentation.enable_debug_mode if options[:debug_mode] == true
        end

        # Create bower directory
        def bower_directory
          @bower_directory ||= BowerDirectory.new(
            root: FeduxOrgStdlib::RecursiveFileFinder.new(file_name: 'config.rb').directory,
            directory: options[:bower_directory],
          )
        end

        # Create assets loader base on bower directory
        def assets_loader
          return @assets_loader if @assets_loader

          @assets_loader = Middleman::Presentation::AssetsLoader.new(bower_directory: bower_directory)
        end

        module ClassMethods
          def self.exit_on_failure?
            true
          end
        end
      end
    end
  end
end
