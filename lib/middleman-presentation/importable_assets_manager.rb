# encoding: utf-8
module Middleman
  module Presentation
    # Frontend Component Manager
    #
    # It know about all frontend components. Information about all frontend
    # components is used when building `application.js` and `application.scss`
    # during website build and when creating the `bower.json`-file on
    # presentation-creation.
    #
    # It normally gets the information about available components from
    # `plugins`.
    class ImportableAssetsManager
      private

      attr_reader :creator

      public

      attr_reader :importable_assets

      def initialize(creator: ImportableAsset)
        @importable_assets = Set.new
        @creator           = creator
      end

      # Add component
      def add(*candidates)
        #candidates.flatten.each do |c|
        #  if c.is_a? creator
        #    asset = c
        #  elsif c.respond_to? :to_h
        #    asset = creator.new(**c.to_h)
        #  else
        #    Middleman::Presentation.logger.warn Middleman::Presentation.t('errors.invalid_importable_asset')
        #    return
        #  end

        #  importable_assets << asset
        #end
      end

      # Load objects from manager
      def load_from(manager)
        objects = creator.parse(manager.known_objects)
        objects.find_all(&:importable?)
      end

      # List installed plugins
      def to_s
        data = importable_assets.sort.reduce([]) do |a, e|
          a << {
            name: e.name,
            resource_locator: e.resource_locator,
            version: e.version,
            javascripts: e.javascripts,
            stylesheets: e.stylesheets
          }
        end

        List.new(data).to_s(fields: [:name, :resource_locator, :version, :javascripts, :stylesheets])
      end
    end
  end
end
