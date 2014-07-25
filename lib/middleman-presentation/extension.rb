# encoding: utf-8
module Middleman
  module Presentation
    class PresentationExtension < Extension
      option :slides_directory, 'slides', 'Pattern for matching source slides'

      helpers Middleman::Presentation::Helpers
    end
  end
end
