# encoding: utf-8
module Middleman
  module Presentation
    class PresentationExtension < Extension
      option :slides_directory, Middleman::Presentation.config.slides_directory, 'Directory to look for slides'
      option :slides_ignore_file, Middleman::Presentation.config.slides_ignore_file, 'File with patterns to (un)ignore slides in output'

      helpers Middleman::Presentation::Helpers
    end
  end
end
