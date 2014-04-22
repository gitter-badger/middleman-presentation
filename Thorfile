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

    def root_directory
      self.class.source_root
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

    def subtree_repository(source, destination)
      Dir.chdir self.class.source_root do
        system("git subtree add --squash -P #{destination} #{source} HEAD")
      end
    end

    def commit_changes(directory, message = 'Commited by bootstrap script')
      Dir.chdir directory do
        system('git add -A .')
        system("git ct -m \"#{message}\"")
      end
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
        run 'middleman build --verbose'
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

  class Uninstall < ApplicationGroup
    def cleanup
      thor 'presentation:clean'
    end

    def remove_nodejs_modules
      remove_dir root_file('node_modules')
    end
  end

  class Bootstrap < ApplicationGroup

    def cleanup_middleman
      remove_dir 'source/'
    end

    def install_rubygems
      run 'bundle install'
    end

    def clone_reveal_js
      subtree_repository('http://github.com/hakimel/reveal.js.git', 'source')
    end
    
    def install_node_modules
      inside source_directory do
        run 'npm install'
        run 'npm install -g grunt-cli'
      end
    rescue
      logger.fatal 'Please make sure you configured npm correctly to use "install -g" as normal user.'
      exit 1
    end

    def cleanup_nodejs_modules
      FileUtils.rm_r Dir.glob(File.join(source_directory, 'node_modules', '**', 'test'))
    end

    def cleanup_reveal_js
      FileUtils.mv source_file('index.html'), source_file('documentation.html')
      remove_dir File.join(source_directory, 'test')
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

    def create_first_slide
      copy_file 'templates/00.html.erb', source_file('slides/00.html.erb')
    end

    def delete_git_ref_to_remote
      system('git remote rm origin')
    end

    def finalize_source_directory
      commit_changes root_directory
    end
  end

  class Cli < Application
    register Build, 'build', 'build', 'Build presentation'
    register Clean, 'clean', 'clean', 'Cleanup presentation directory'
    register Bootstrap, 'bootstrap', 'bootstrap', 'Bootstrap application'
  end
end

