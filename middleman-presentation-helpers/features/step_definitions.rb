# encoding: utf-8

Given(/^an image "([^"]+)" at "([^"]+)"$/) do |source, destination|
  source = source.gsub(/\.\./, '')
  write_file File.join('source', destination), File.read(File.expand_path("../../fixtures/images/#{source}", __FILE__))
end
