#!/usr/bin/env ruby

# encoding: utf-8
require 'English'

Rake::TaskManager.record_task_metadata = true

desc 'Run tests'
task test: ['test:core', 'test:helpers']
task 'test:ci' => ['bootstrap:shell_environment', 'bootstrap:gem_requirements', 'test:freeze_bundle', :test]

namespace :test do
  desc 'Freeze bundle'
  task :freeze_bundle do |t|
    puts t.comment
    ENV['BUNDLE_FROZEN'] = '1'
    puts format('BUNDLE_FROZEN: %s', ENV['BUNDLE_FROZEN'])
  end

  desc 'Run tests for core'
  task :core do |t|
    Dir.chdir 'middleman-presentation-core' do
      puts t.comment
      sh 'rake test:coveralls'
    end
  end

  desc 'Run rubocop tests for core'
  task 'core:rubocop' do |t|
    Dir.chdir 'middleman-presentation-core' do
      puts t.comment
      sh 'rake test:rubocop'
    end
  end

  desc 'Run rspec tests for core'
  task 'core:rspec' do |t|
    Dir.chdir 'middleman-presentation-core' do
      puts t.comment
      sh 'rake test:rspec'
    end
  end

  desc 'Run tests for helpers'
  task :helpers do |t|
    Dir.chdir 'middleman-presentation-helpers' do
      puts t.comment
      sh 'rake test:coveralls'
    end
  end

  desc 'Run rubocop tests for helpers'
  task 'helpers:rubocop' do |t|
    Dir.chdir 'middleman-presentation-helpers' do
      puts t.comment
      sh 'rake test:rubocop'
    end
  end

  desc 'Run rspec tests for helpers'
  task 'helpers:rspec' do |t|
    Dir.chdir 'middleman-presentation-helpers' do
      puts t.comment
      sh 'rake test:rspec'
    end
  end
end

desc 'Push sources'
task push: 'source:push'

namespace :source do
  desc 'Push sources'
  task push: ['test:core:rspec', 'test:core:rubocop', 'test:helpers:rspec', 'test:helpers:rubocop'] do |t|
    puts t.comment
    sh 'git push'
  end
end

# Run some tests before releasing
task 'gem:release' => ['test:core:rspec', 'test:core:rubocop', 'test:helpers:rspec', 'test:helpers:rubocop']

%w(build install release).each do |task_name|
  desc task_name.capitalize
  task "gem:#{task_name}" => ["#{task_name}:core", "#{task_name}:helpers", "#{task_name}:main"]
  namespace "gem:#{task_name}" do
    desc "#{task_name.capitalize} main"
    task :main do |t|
      Dir.chdir 'middleman-presentation' do
        puts t.comment
        sh "rake gem:#{task_name}"
      end
    end

    desc "#{task_name.capitalize} core"
    task :core do |t|
      Dir.chdir 'middleman-presentation-core' do
        puts t.comment
        sh "rake gem:#{task_name}"
      end
    end

    desc "#{task_name.capitalize} helpers"
    task :helpers do |t|
      Dir.chdir 'middleman-presentation-helpers' do
        puts t.comment
        sh "rake gem:#{task_name}"
      end
    end
  end
end

desc 'Bootstrap project'
task bootstrap: %w(bootstrap:bower bootstrap:bundler bootstrap:webserver)

desc 'Bootstrap project for ci'
task 'bootstrap:ci' => %w(bootstrap:shell_environment bootstrap:clean_caches) do
  Rake::Task['bootstrap'].invoke
end

namespace :bootstrap do
  desc 'Bootstrap bower'
  task :bower do |t|
    puts t.comment
    sh 'npm install -g bower'

    fail RuntimeError, "Make sure you've got 'npm' and 'bower' installed on your system! 'npm' comes with nodejs. Please see http://nodejs.org/ for information about 'node.js/npm' and http://bower.io/ for more information about installing 'bower' on your system." unless $CHILD_STATUS.exitstatus == 0
  end

  desc 'Bootstrap bundler'
  task :bundler do |t|
    puts t.comment
    sh 'gem install bundler'
    sh 'bundle install'
  end

  task :webserver do |t|
    puts t.comment
    Dir.chdir 'middleman-presentation-core' do
      sh 'rake webserver:fetch'
    end
  end

  desc 'Clean bower and bundler caches'
  task :clean_caches do |t|
    puts t.comment

    FileUtils.rm_rf File.expand_path('../tmp/bundler_cache', __FILE__)
    FileUtils.rm_rf File.expand_path('../tmp/bower_cache', __FILE__)
  end

  desc 'Prepare shell environment for testing'
  task :shell_environment do |t|
    puts t.comment
    ENV['BUNDLE_PATH'] = File.expand_path('../tmp/bundler_cache', __FILE__)
    ENV['GEM_HOME'] = File.expand_path('../tmp/bundler_cache', __FILE__)
    ENV['bower_storage__packages'] = File.expand_path('../tmp/bower_cache', __FILE__)

    puts format('BUNDLE_PATH:   %s', ENV['BUNDLE_PATH'])
    puts format('GEM_HOME:      %s', ENV['GEM_HOME'])
    puts format('BOWER_CACHE:   %s', ENV['bower_storage__packages'])
  end

  desc 'Require gems'
  task :gem_requirements do |t|
    puts t.comment
    require 'bundler'
    Bundler.require
  end
end

namespace :docker do
  task :build do
    sh 'docker build -t middleman-presentation:latest .'
  end
end

namespace :documentation do
  task :inch do
    sh 'inch'
  end
end

namespace :docker do
  task :build do
    sh 'docker build -t middleman-presentation:latest .'
  end

  task :run do
    sh 'docker run --name middleman-presentation1 --rm -it middleman-presentation:latest bash'
  end
end
