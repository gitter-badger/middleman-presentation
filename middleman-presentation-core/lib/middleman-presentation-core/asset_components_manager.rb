# encoding: utf-8
module Middleman
  module Presentation
    # Asset Component Manager
    #
    # It know about all asset components. Information about all asset
    # components is used when building `application.js` and `application.scss`
    # during website build.
    #
    # It normally gets the information about available components from
    # `plugins`.
    class AssetComponentsManager
      private

      attr_reader :creator

      protected

      attr_reader :components

      public

      def initialize(creator: AssetComponent)
        @components = Set.new
        @creator    = creator
      end

      # Return available frontend components
      def available_components
        components.to_a
      end

      # Iterate over all components
      def each_component(&block)
        components = self.components.to_a
        return components.each unless block_given?

        components.each do |c|
          block.call(c, c.equal?(components.last))
        end
      end

      # Add component
      def add(c)
        unless c.respond_to? :to_h
          Middleman::Presentation.logger.error Middleman::Presentation.t('errors.invalid_component', argument: c)

          return
        end

        components << creator.new(**c.to_h)
      end

      # List installed plugins
      def to_s
        data = components.sort.reduce([]) do |a, e|
          a << {
            path: e.path,
            resource_locator: e.resource_locator,
            version: e.version,
            loadable_files: e.loadable_files,
            importable_files: e.importable_files,
            ignorable_files: e.ignorable_files,
            output_directories: e.output_directories
          }
        end

        List.new(data).to_s(fields: [:path, :resource_locator, :version, :importable_files, :loadable_files, :ignorable_files, :output_directories])
      end
    end
  end
end
