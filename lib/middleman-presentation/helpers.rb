# encoding: utf-8
module Middleman
  module Presentation
    module Helpers
    end
  end
end

# Require all files found in helpers directory
Dir.glob(File.expand_path('../helpers/*.rb', __FILE__)).each { |path| require path }
