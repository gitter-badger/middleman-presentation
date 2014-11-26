#!/usr/bin/env ruby

task default: 'app:build'

namespace :app do
  source_file = 'src/server.go'
  destination_file = 'bin/server'

  task :clean do
    FileUtils.rm_rf 'bin/'
    FileUtils.mkdir_p 'bin/'
  end

  task build: %w(app:clean app:prepare) do
    [
      %(export GOOS=windows GOARCH=amd64; go build -o #{destination_file}.$GOOS.$GOARCH.exe #{source_file}),
      %(export GOOS=linux GOARCH=amd64; go build -o #{destination_file}.$GOOS.$GOARCH #{source_file}),
      %(export GOOS=darwin GOARCH=amd64; go build -o #{destination_file}.$GOOS.$GOARCH #{source_file}),
    ].each { |cmd| sh cmd }
  end

  task :prepare do
    FileUtils.ln_s 'server.linux.amd64', destination_file
  end
end
