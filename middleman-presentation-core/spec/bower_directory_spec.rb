# encoding: utf-8
require 'spec_helper'

RSpec.describe BowerDirectory do
  context '#absolute_path' do
    it 'returns absolute path' do
      dir = BowerDirectory.new(root_directory: absolute_path('.'), directory: 'bower_components')
      expect(dir.absolute_path).to eq Pathname.new(absolute_path('bower_components'))
    end

    it 'returns relative path' do
      dir = BowerDirectory.new(root_directory: absolute_path('.'), directory: 'bower_components')
      expect(dir.relative_path).to eq Pathname.new('bower_components')
    end
  end
end
