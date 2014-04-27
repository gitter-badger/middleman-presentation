# encoding: utf-8
module Middleman
  class PresentationExtension < Extension
    def initialize(app, options_hash={}, &block)
      super
    end

    helpers do
      def yield_slides
        Slides.clear
        Slides.create_from(File.join(root, 'slides'))

        Slides.all.each do |s|
          partial s.relative_to_path(root)
        end
      end
    end
  end

end
