#!/usr/bin/env ruby

require 'fedux_org_stdlib/core_ext/array/list'
require 'fedux_org_stdlib/rake_tasks/gems'

@repositories = %w(
  core
  helpers
)

@prefix = 'middleman-presentation'

def directories
  @repositories.map { |r| @prefix + '-' + r }
end

def each_directory(&block)
  @repositories.each { |r| block.call(r, @prefix + '-' + r) }
end

def map_directory(&block)
  @repositories.map { |r| block.call(r, @prefix + '-' + r) }
end

def tasks(prefix)
  map_directory { |r,_| "#{prefix}:#{r}" }
end

desc "Run tests for #{directories.to_list}"
task :test => tasks('test')

namespace :test do
  each_directory do |r, d|
    desc "Run tests in directory \"#{d}\"."
    task r do
      Dir.chdir d do
        sh 'rake test'
      end
    end
  end
end

desc "Release gems #{directories.to_list}"
task 'gem:release' => tasks('gem:release')

namespace :gem do
  namespace :release do
    each_directory do |r, d|
      desc "Release gem \"#{d}\"."
      task r do
        Dir.chdir d do
          sh 'rake gem:release'
        end
      end
    end
  end
end

desc "Install gems #{directories.to_list}"
task 'gem:install' => tasks('gem:install')

namespace :gem do
  namespace :install do
    each_directory do |r, d|
      desc "Install gem \"#{d}\"."
      task r do
        Dir.chdir d do
          sh 'rake gem:install'
        end
      end
    end
  end
end
