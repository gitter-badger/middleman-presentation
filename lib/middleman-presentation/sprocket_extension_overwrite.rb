# encoding: utf-8
require 'middleman-sprockets/extension'

module Middleman
  class SprocketsExtension
    # Add sitemap resource for every image in the sprockets load path
    def manipulate_resource_list(resources)
      imported_assets = []
      environment.imported_assets.each do |asset_logical_path|
        assets = []
        environment.resolve(asset_logical_path) do |asset|
          assets << asset
          @app.logger.debug "== Importing Sprockets asset #{asset}"
        end
        raise ::Sprockets::FileNotFound, "couldn't find asset '#{asset_logical_path}'" if assets.empty?
        imported_assets += assets
      end

      resources_list = []
      environment.paths.each do |load_path|
        candidate_dir = nil
        export_all = false
        if load_path.end_with?('/images')
          candidate_dir = @app.config[:images_dir]
          export_all = true
        elsif load_path.end_with?('/fonts')
          candidate_dir = @app.config[:fonts_dir]
          export_all = true
        elsif load_path.end_with?('/stylesheets')
          candidate_dir = @app.config[:css_dir]
        elsif load_path.end_with?('/javascripts')
          candidate_dir = @app.config[:js_dir]
        end

        environment.each_entry(load_path) do |path|
          next unless path.file?
          next if path.basename.to_s.start_with?('_')

          next unless export_all || imported_assets.include?(path)

          # For all imported assets that aren't in an obvious directory, figure out their
          # type (and thus output directory) via extension.
          output_dir = if candidate_dir
                         candidate_dir
                       else
                         case File.extname(path)
                         when '.js', '.coffee'
                           @app.config[:js_dir]
                         when '.css', '.sass', '.scss', '.styl', '.less'
                           @app.config[:css_dir]
                         when '.gif', '.png', '.jpg', '.jpeg', '.svg', '.svg.gz'
                           @app.config[:images_dir]
                         when '.ttf', '.woff', '.eot', '.otf'
                           @app.config[:fonts_dir]
                         end
                       end

          if !output_dir
            raise ::Sprockets::FileNotFound, "couldn't find an appropriate output directory for '#{path}' - halting because it was explicitly requested via 'import_asset'"
          end

          base_path = path.sub("#{load_path}/", '')
          new_path = @app.sitemap.extensionless_path(File.join(output_dir, base_path))

          next if @app.sitemap.find_resource_by_destination_path(new_path)
          resources_list << ::Middleman::Sitemap::Resource.new(@app.sitemap, new_path.to_s, path.to_s)
        end
      end
      resources + resources_list
    end
  end
end
