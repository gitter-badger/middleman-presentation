#!/usr/bin/env ruby
# encoding: utf-8

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

require 'presentation/version'
require 'logger'

module Presentation
  module CliHelper
    def logger
      @logger ||= Logger.new($stderr)
    end

    def source_directory
      File.join(self.class.source_root, 'source')
    end

    def build_directory
      File.join(self.class.source_root, 'build')
    end

    def clone_repository(source, destination)
      system("git clone #{source} #{File.join(self.class.source_root, destination)}")
    end

    def source_directory
      File.join(self.class.source_root, 'source')
    end

    def source_file(file)
      File.join(source_directory, file)
    end

    def root_file(file)
      File.join(self.class.source_root, file)
    end
  end
end

module Presentation
  class ApplicationGroup < Thor::Group
    include Thor::Actions
    include Presentation::CliHelper

    def self.source_root
      File.expand_path('../', __FILE__)
    end
  end

  class Application < Thor
    include Thor::Actions
    include Presentation::CliHelper

    def self.source_root
      File.expand_path('../', __FILE__)
    end
  end

end

module Presentation
  class Build < ApplicationGroup
    def build_presentation
      unless File.exists? source_directory
        logger.warn "Source directory \"#{source_directory}\" does not exist. Please run \"#{File.expand_path('../script/bootstrap', __FILE__)}\" to initialize project." 
        exit 1
      end

      Dir.chdir source_directory do
        run 'middleman build'
      end
    end
  end

  class Clean < ApplicationGroup
    def remove_source_directory
      remove_dir source_directory
    end

    def remove_build_directory
      remove_dir build_directory
    end
  end

  class Bootstrap < ApplicationGroup
    def install_software
      run 'bundle install'
    end

    def cleanup_middleman
      remove_dir 'source/'
    end

    def clone_reveal_js
      clone_repository('http://github.com/hakimel/reveal.js.git', 'source')
    end

    def cleanup_reveal_js
      FileUtils.mv source_file('index.html'), source_file('documentation.html')
    end

    def create_slides_directory
      empty_directory 'source/slides'
    end

    def create_layouts_directory
      empty_directory 'source/layouts'
    end

    def create_application_layout_file
      copy_file 'templates/layout.erb', source_file('layout.erb')
    end

    def copy_index_html_template
      copy_file 'templates/index.html.erb', source_file('index.html.erb')
    end

    def copy_gitignore
      copy_file 'templates/.gitignore', root_file('.gitignore')
    end
  end

  class Cli < Application
    register Build, 'build', 'build', 'Build presentation'
    register Clean, 'clean', 'clean', 'Cleanup presentation directory'
    register Bootstrap, 'bootstrap', 'bootstrap', 'Bootstrap application'
  end
end

