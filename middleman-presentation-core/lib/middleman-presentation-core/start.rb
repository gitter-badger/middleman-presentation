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

          bower_directory = Middleman::Presentation::BowerDirectory.new(root_directory: root, directory: Middleman::Presentation.config.bower_directory)
          Middleman::Presentation::AssetsLoader.new(bower_directory: bower_directory).load_at_presentation_runtime

          helpers Middleman::Presentation.helpers_manager.available_helpers

          set :markdown_engine, :kramdown
          set :markdown, parse_block_html: true

          # ignore slides so that a user doesn't need to prepend slide names
          # with an underscore
          ignore 'slides/*'

          # all fetchable components reside in the bower directory. Their
          # assets are required with "component_name/path/to/asset.scss".
          # Therefore it's suffice enough to add the bower directory only.
          sprockets.append_path File.join(root, bower_directory.relative_path)

          # all non fetchable components can be hidden in rubygems and
          # therefor the full path to that components needs to be added
          Middleman::Presentation.components_manager.each_nonfetchable_component { |c| sprockets.append_path c.path }

          Middleman::Presentation.assets_manager.each_loadable_asset do |a|
            sprockets.import_asset a.load_path, &a.destination_path_resolver
          end
        end
      end
    end
  end
end
