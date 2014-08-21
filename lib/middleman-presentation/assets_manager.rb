# encoding: utf-8
module Middleman
  module Presentation
    # Manager for assets
    class AssetsManager
      private

      attr_reader :assets, :bower_directory

      public

      def initialize(bower_directory:)
        @assets          = Set.new
        @bower_directory = File.expand_path(bower_directory)
      end

      # Load default assets
      def load_default_assets_in_bower_directory
        default_assets.each { |k, v| add(k, v) }
      end

      # Add helpers
      def add(source_path, destination_directory = nil, creator: Asset)
        assets << creator.new(
          source_path: source_path,
          destination_directory: destination_directory
        )
      end

      # Show assets which should be imported
      def to_s
        data = assets.reduce([]) do |a, e|
          a << { source_path: e.source_path, destination_directory: e.destination_directory }
        end

        List.new(data).to_s
      end

      # Load assets from path
      def load_from(base_path)
        search_path = File.join(base_path, '**', '*')

        Dir.glob(search_path).each do |p|
          next unless File.file? p

          new_path = File.join(*Pathname.new(p).relative_path_from(Pathname.new(base_path)).each_filename.to_a.slice(1..-1))
          add(new_path)
        end
      end

      # Iterate over assets
      def each_asset(&block)
        assets.dup.each(&block)
      end

      private

      def default_assets
        result = {}

        patterns = [
          '.png',  '.gif', '.jpg', '.jpeg', '.svg', # Images
          '.eot',  '.otf', '.svc', '.woff', '.ttf', # Fonts
          '.js',                                    # Javascript
        ].map { |e| File.join(bower_directory, '**', "*#{e}") }

        list = Rake::FileList.new(*patterns) do |l|
          l.exclude(/src/)
          l.exclude(/test/)
          l.exclude(/demo/)
          l.exclude { |f| !File.file? f }
        end

        list.each do |f|
          result[Pathname.new(f).relative_path_from(Pathname.new(bower_directory))] = nil
        end

        Rake::FileList.new(File.join(bower_directory, '**', 'notes.html')).each do |f|
          result[Pathname.new(f).relative_path_from(Pathname.new(bower_directory))] = Pathname.new('javascripts')
        end

        Rake::FileList.new(File.join(bower_directory, '**', 'pdf.css')).each do |f|
          result[Pathname.new(f).relative_path_from(Pathname.new(bower_directory))] = Pathname.new('stylesheets')
        end

        result
      end
    end
  end
end
