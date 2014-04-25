# encoding: utf-8
require 'pathname'

module Middleman
  class RevealjsExtension < Extension
    def initialize(app, options_hash={}, &block)
      super
    end

    helpers do
      def yield_slides
        slides.each do |s|
          partial File.join('slides', File.basename(s, '.*'))
        end
      end
    end

    private

    def slides
      files_in_slides_directory.collect { |f| make_path_relative(f).to_s }
    end

    def files_in_slides_directory
      Dir.glob(File.join(slides_directory, '*.*')).keep_if { |f| File.file? f }
    end

    def slides_directory
      Pathname.new(File.join(root, 'slides'))
    end

    def make_path_relative(path)
      Pathname.new(path).relative_path_from(slides_directory).to_s
    end
  end

end
::Middleman::Extensions.register(:revealjs, Revealjs)
