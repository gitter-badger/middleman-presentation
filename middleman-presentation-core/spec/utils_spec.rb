# encoding: utf-8
require 'spec_helper'

RSpec.describe Utils do
  context '#zip' do
    it 'creates a zip archive from directory' do
      touch_file 'test.txt'

      Middleman::Presentation::Utils.zip absolute_path('.'), absolute_path('test.zip')

      check_file_presence(['test.zip'], true)
    end
  end
end
