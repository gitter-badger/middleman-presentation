# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'export presentation' command for the middleman CLI.
      class Export < Base
        include Thor::Actions

        option :output_file, desc: Middleman::Presentation.t('views.presentations.export.options.output_file')
        option :prefix, desc: Middleman::Presentation.t('views.presentations.export.options.prefix')
        desc 'presentation', Middleman::Presentation.t('views.presentation.export.title')
        def presentation
          shared_instance = ::Middleman::Application.server.inst

          data = if shared_instance.data.respond_to? :metadata
                   shared_instance.data.metadata.dup
                 else
                   OpenStruct.new(date: Time.now.strftime('%Y%m%d_%H%M%S'), title: 'presentation')
                 end

          output_file = File.expand_path(
            options.fetch('output_file', ActiveSupport::Inflector.transliterate(data.date.to_s + '-' + data.title.to_s).parameterize + '.zip')
          )

          fail Middleman::Presentation.t('errors.zip_filename_error', name: File.basename(output_file)) unless output_file.end_with? '.zip'

          prefix = options.fetch('prefix', ActiveSupport::Inflector.transliterate(data.date.to_s + '-' + data.title.to_s).parameterize)

          Middleman::Presentation.logger.info Middleman::Presentation.t(
            'views.presentation.export.headline', 
            title: data.title, 
            file: output_file
          )

          result = run('middleman build', capture: true)
          fail Thor::Error, Middleman::Presentation.t('errors.middleman_build_error', result: result) unless $CHILD_STATUS.exitstatus == 0

          Middleman::Presentation::Utils.zip(File.join(shared_instance.root, shared_instance.build_dir), File.expand_path(output_file), prefix: prefix)
        end
      end
    end
  end
end
