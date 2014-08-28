# encoding: utf-8
module Middleman
  module Presentation
    module Cli
      # This class provides an 'presentation init' command for the middleman CLI.
      class List < Base
        include Thor::Actions

        desc 'plugins', Middleman::Presentation.t('views.plugins.list.title')
        def plugins
          puts Middleman::Presentation.plugins_manager.to_s
        end

        desc 'helpers', Middleman::Presentation.t('views.helpers.list.title')
        def helpers
          puts Middleman::Presentation.helpers_manager.to_s
        end

        desc 'assets', Middleman::Presentation.t('views.assets.list.title')
        def assets
          puts Middleman::Presentation.assets_manager.to_s
        end

        desc 'frontend_components', Middleman::Presentation.t('views.frontend_components.list.title')
        def frontend_components
          puts Middleman::Presentation.frontend_components_manager.to_s
        end

        desc 'styles', Middleman::Presentation.t('views.styles.list.title')
        def styles
          css_classes = Middleman::Presentation::CssClassExtracter.new.extract Middleman::Presentation.stylable_files, ignore: %w(slides reveal)

          puts Middleman::Presentation.t('views.styles.list.headline')
          css_classes.each { |klass| puts format '  %20s: %s', klass.name, klass.files.to_list }
          puts
        end
      end
    end
  end
end
