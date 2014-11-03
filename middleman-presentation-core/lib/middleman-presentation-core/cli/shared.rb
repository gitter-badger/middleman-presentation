# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Bundle shared methods for all cli classes
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
          MiddlemanEnvironment.new.bower_path
        end

        # Create assets loader base on bower directory
        def assets_loader
          return @assets_loader if @assets_loader

          @assets_loader = Middleman::Presentation::AssetsLoader.new(bower_directory: bower_directory)
        end

        def open_in_editor(paths)
          editor = []

          begin
            editor << Erubis::Eruby.new(options[:editor_command]).result(Middleman::Presentation.config.to_h)
          rescue NameError => e
            $stderr.puts Middleman::Presentation.t('errors.missing_data_attribute', message: e.message)
          end
          editor.concat paths

          Middleman::Presentation.logger.warn Middleman::Presentation.t('infos.open_slide_in_editor', editor: editor.first)
          system(editor.join(' '))
        end

        # The class methods
        module ClassMethods
          def self.exit_on_failure?
            true
          end
        end
      end
    end
  end
end
