#!/usr/bin/env ruby

require 'thor'
require 'thor/group'
require 'thor/actions'

class Default < Thor::Group
  include Thor::Actions

  def blub
    run 'middleman build --verbose'
  end
end
