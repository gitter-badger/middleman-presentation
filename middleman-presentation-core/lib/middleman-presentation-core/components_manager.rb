# encoding: utf-8
module Middleman
  module Presentation
    # Component Manager
    #
    # It know about all frontend components. Information about all frontend
    # components is used when building `application.js` and `application.scss`
    # during website build and when creating the `bower.json`-file on
    # presentation-creation.
    #
    # It normally gets the information about available components from
    # `plugins`.
    class ComponentsManager
      private

      attr_reader :bower_directory, :cache

      public

      def initialize(bower_directory: nil, cache: Cache.new(store: Set.new))
        @bower_directory = bower_directory
        @cache           = cache 
      end

      # Return available frontend components
      def available_components
        components.to_a
      end

      def bower_directory=(value)
        @bower_directory = value
        cache.mark_dirty
      end

      # Return components
      #
      # Will used cached results until a new component is added
      def components
        cache.each { |c| c.root_directory = bower_directory }

        cache.to_a
      end

      # Iterate over all fetchable components
      def each_fetchable_component(&block)
        components = self.components.select(&:fetchable?)

        return components.each unless block_given?

        components.each do |c|
          block.call(c, c.equal?(components.last))
        end
      end

      # Iterate over all fetchable components
      def each_nonfetchable_component(&block)
        components = self.components.select { |c| !c.fetchable? }

        return components.each unless block_given?

        components.each do |c|
          block.call(c, c.equal?(components.last))
        end
      end

      # Add component
      def add(c)
        unless c.respond_to? :root_directory=
          Middleman::Presentation.logger.error Middleman::Presentation.t('errors.invalid_component', argument: c)
          return
        end

        cache.add c
      end

      # List installed plugins
      def to_s
        data = components.sort.reduce([]) do |a, e|
          a << {
            name: e.name,
            path: e.path,
            base_path: e.base_path,
            resource_locator: e.resource_locator,
            version: e.version,
            loadable_files: e.loadable_files,
            importable_files: e.importable_files,
            ignorable_files: e.ignorable_files,
            output_directories: e.output_directories
          }
        end

        List.new(data).to_s(fields: [:name, :path, :base_path, :resource_locator, :version, :importable_files, :loadable_files, :ignorable_files, :output_directories])
      end
    end
  end
end
