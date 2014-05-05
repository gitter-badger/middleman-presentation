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

    def add_files_for_presentation
      run 'bundle exec middleman presentation'
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

