# encoding: utf-8
module Middleman
  module Presentation
    # if fixture cannot be found by name
    class FixtureNotFoundError < StandardError; end

    # if plugin cannot be found by name
    class PluginNotFoundError < StandardError; end
  end
end
