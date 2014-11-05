#!/usr/bin/env ruby

require 'fedux_org_stdlib/core_ext/array/list'
require 'English'

desc 'Run tests'
task :test => ['test:core', 'test:helpers']
task 'test:ci' => ['bootstrap:shell_environment', 'bootstrap:gem_requirements'] do
  Rake::Task['test:coveralls'].invoke
end

namespace :test do
  desc 'Run tests for core'
  task :core do
    Dir.chdir 'middleman-presentation-core' do
      sh 'rake test'
    end
  end

  desc 'Run tests for helpers'
  task :helpers do
    Dir.chdir 'middleman-presentation-helpers' do
      sh 'rake test'
    end
  end
end

%w(build install release).each do |task_name|
  desc task_name.capitalize
  task "gem:#{task_name}" => ["#{task_name}:core", "#{task_name}:helpers", "#{task_name}:main"]
  namespace "gem:#{task_name}" do
    desc "#{task_name.capitalize} main"
    task :main do
      Dir.chdir "middleman-presentation" do
        sh "rake gem:#{task_name}"
      end
    end

    desc "#{task_name.capitalize} core"
    task :core do
      Dir.chdir "middleman-presentation-core" do
        sh "rake gem:#{task_name}"
      end
    end

    desc "#{task_name.capitalize} helpers"
    task :helpers do
      Dir.chdir "middleman-presentation-helpers" do
        sh "rake gem:#{task_name}"
      end
    end
  end
end

desc 'Bootstrap project'
task :bootstrap => ['bootstrap:bower', 'bootstrap:bundler']

desc 'Bootstrap project for ci'
task 'bootstrap:ci' => 'bootstrap:shell_environment' do
  Rake::Task['bootstrap'].invoke
end

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

  task :shell_environment do
    ENV['BUNDLE_PATH'] = File.expand_path('../tmp/bundler_cache', __FILE__)
    ENV['GEM_HOME'] = File.expand_path('../tmp/bundler_cache', __FILE__)
    ENV['bower_storage__packages'] = File.expand_path('../tmp/bower_cache', __FILE__)

    puts format('BUNDLE_PATH: %s', ENV['BUNDLE_PATH'])
    puts format('GEM_HOME:    %s', ENV['GEM_HOME'])
    puts format('BOWER_CACHE:    %s', ENV['bower_storage__packages'])
  end

  task :gem_requirements do
    Bundler.require
  end
end
