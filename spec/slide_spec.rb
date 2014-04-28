# encoding: utf-8
require 'spec_helper'

describe Slide do
  context '#relative_path' do
    it 'path relative to base dir' do
      file = create_file 'slides/01.html.erb', '<section></section>'
      slide = Slide.new(file)

      expect(slide.relative_as_partial(working_directory)).to eq 'slides/01'
    end
  end
end
