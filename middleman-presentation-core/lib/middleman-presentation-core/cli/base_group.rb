# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # Base group cli class
      class BaseGroup < Thor::Group
        def self.exit_on_failure?
          true
        end

        no_commands do
          def enable_debug_mode
            Middleman::Presentation.enable_debug_mode if options[:debug_mode] == true
          end

          def shared_instance
            middleman_instance ||= proc { ::Middleman::Application.server.inst }.call

            fail Thor::Error, Middleman::Presentation.t('errors.extension_not_activated') unless middleman_instance.extensions.key? :presentation

            middleman_instance
          end

          def presentation_inst
            shared_instance.extensions[:presentation]
          end

          def open_in_editor(paths)
            data = if shared_instance.data.respond_to?(:metadata)
                     shared_instance.data.metadata.dup
                   else
                     OpenStruct.new
                   end

            editor = []

            begin
              editor << Erubis::Eruby.new(options[:editor_command]).result(data)
            rescue NameError => e
              $stderr.puts Middleman::Presentation.t('errors.missing_data_attribute', message: e.message)
            end
            editor.concat paths

            Middleman::Presentation.logger.warn Middleman::Presentation.t('infos.open_slide_in_editor', editor: editor.first)
            system(editor.join(' '))
          end
        end
      end
    end
  end
end
