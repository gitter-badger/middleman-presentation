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
    class FrontendComponentsManager
      private

      attr_reader :components, :creator, :bower_directory

      public

      def initialize(creator: FrontendComponent, bower_directory: nil)
        @components     = Set.new
        @creator        = creator
        @bower_directory = bower_directory
      end

      # Return available frontend components
      def available_components
        components.to_a
      end

      # Iterate over all components
      def each_component(&block)
        components = components.to_a

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

        components << creator.new(**c.to_h.merge(root_directory: bower_directory))
      end

      # List installed plugins
      def to_s
        data = components.sort.reduce([]) do |a, e|
          a << {
            name: e.name,
            resource_locator: e.resource_locator,
            version: e.version,
            loadable_files: e.loadable_files,
            importable_files: e.importable_files,
            ignorable_files: e.ignorable_files,
            output_directories: e.output_directories,
            root_directory: e.root_directory
          }
        end

        List.new(data).to_s(fields: [:name, :resource_locator, :version, :importable_files, :loadable_files, :ignorable_files, :output_directories])
      end
    end
  end
end
