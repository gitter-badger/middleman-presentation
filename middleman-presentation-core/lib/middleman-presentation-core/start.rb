# encoding: utf-8
# Main
module Middleman
  # Presentation extension
  module Presentation
    class << self
      def start(environment)
        environment.instance_eval do
          activate :sprockets unless respond_to? :sprockets

          # For testing only otherwise config = Middleman::Pre...::Config.new
          # is run before the new home is set and the config file is created
          # and there is not used.
          Middleman::Presentation.config.redetect if ENV['MP_ENV'] == 'test'

          set :js_dir, Middleman::Presentation.config.scripts_directory
          set :images_dir, Middleman::Presentation.config.images_directory
          set :build_dir, Middleman::Presentation.config.build_directory
          set :css_dir, Middleman::Presentation.config.stylesheets_directory
          set :source_dir, Middleman::Presentation.config.sources_directory

          Middleman::Presentation::AssetsLoader.new(bower_directory: MiddlemanEnvironment.new.bower_path).load_at_presentation_runtime

          helpers Middleman::Presentation.helpers_manager.available_helpers

          set :markdown_engine, :kramdown
          set :markdown,
              parse_block_html: true,
              tables: true,
              syntax_highlighter: 'middleman_presentation',
              syntax_highlighter_opts: {
                code_block_class: 'mp-code-block',
                inline_code_class: 'mp-code-inline'
              },
              smartypants: true,
              smart_quotes: Middleman::Presentation.config.smart_quotes

          # ignore slides so that a user doesn't need to prepend slide names
          # with an underscore
          ignore 'slides/*'

          # all fetchable components reside in the bower directory. Their
          # assets are required with "component_name/path/to/asset.scss".
          # Therefore it's suffice enough to add the bower directory only.
          sprockets.append_path Pathname.new(File.join(root, Middleman::Presentation::MiddlemanEnvironment.new.bower_directory))

          # all non fetchable components can be hidden in rubygems and
          # therefor the full path to that components needs to be added
          Middleman::Presentation.components_manager.each_nonfetchable_component do |c|
            next if sprockets.appended_paths.include? c.path

            sprockets.append_path c.path
          end

          Middleman::Presentation.assets_manager.each_loadable_asset do |a|
            sprockets.import_asset a.load_path, &a.destination_path_resolver
          end

          activate :autoprefixer

          configure :build do
            if Middleman::Presentation.config.minify_assets
              activate :minify_css
              activate :minify_javascript
              activate :minify_html
            end
          end
        end
      end
    end
  end
end
