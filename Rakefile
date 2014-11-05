#!/usr/bin/env ruby

require 'fedux_org_stdlib/core_ext/array/list'
require 'English'

@repositories = [
  'core',
  'helpers'
#  ''
]

@prefix = 'middleman-presentation'

def prefixed(value)
  value = if value.empty?
            ''
          else
            '-' + value
          end
  @prefix +  value
end

def directories
  @repositories.map { |r| prefixed(r) }
end

def each_directory(&block)
  @repositories.each { |r| block.call(r, prefixed(r)) }
end

def map_directory(&block)
  @repositories.map { |r| block.call(r, prefixed(r)) }
end

def tasks(prefix)
  map_directory { |r, _| "#{prefix}:#{r}" }
end

desc "Run tests for #{directories.to_list}"
task test: tasks('test')

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

desc "Run tests in ci mode for #{directories.to_list}"
task 'test:coveralls' => tasks('test:coveralls')

desc "Run rubocop for #{directories.to_list}"
task 'test:rubocop' => tasks('rubocop')

namespace :test do
  namespace :coveralls do
    each_directory do |r, d|
      desc "Run tests in ci mode in directory \"#{d}\"."
      task r do
        Dir.chdir d do
          sh 'rake test:coveralls'
        end
      end
    end
  end

  namespace :rubocop do
    each_directory do |r, d|
      desc "Run rubocop."
      task r do
        Dir.chdir d do
          sh 'rake test:rubocop'
        end
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

desc "Build gems #{directories.to_list}"
task 'gem:build' => tasks('gem:build')

namespace :gem do
  namespace :build do
    each_directory do |r, d|
      desc "Build gem \"#{d}\"."
      task r do
        Dir.chdir d do
          sh 'rake gem:build'
        end
      end
    end
  end
end

desc 'Bootstrap project'
task :bootstrap => ['bootstrap:bower', 'bootstrap:bundler']

namespace :bootstrap do
  desc 'Bootstrap bower'
  task :bower do
    sh 'npm install -g bower'

    fail RuntimeError, "Make sure you've got 'npm' and 'bower' installed on your system! 'npm' comes with nodejs. Please see http://nodejs.org/ for information about 'node.js/npm' and http://bower.io/ for more information about installing 'bower' on your system." unless $CHILD_STATUS.exitstatus == 0
  end

  desc 'Bootstrap bundler'
  task :bundler do
    sh 'gem install bundler'
    sh 'bundle install'
  end

  desc 'Bootstrap project for ci'
  task :ci do
    ENV['BUNDLE_PATH'] = File.expand_path('../tmp/bundler_cache', __FILE__)
    ENV['GEM_HOME'] = File.expand_path('../tmp/bundler_cache', __FILE__)

    puts format('BUNDLE_PATH: %s', ENV['BUNDLE_PATH'])
    puts format('GEM_HOME:    %s', ENV['GEM_HOME'])

    Rake::Task['bootstrap'].invoke
  end
end
