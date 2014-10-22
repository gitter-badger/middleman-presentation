# encoding: utf-8
module Middleman
  module Presentation
    # Presentation extension
    class MiddlemanExtension < Extension
      option :slides_directory, Middleman::Presentation.config.slides_directory, 'Directory to look for slides'
      option :slides_ignore_file, Middleman::Presentation.config.slides_ignore_file, 'File with patterns to (un)ignore slides in output'
    end
  end
end

::Middleman::Extensions.register(:presentation) do
  ::Middleman::Presentation::MiddlemanExtension
end
