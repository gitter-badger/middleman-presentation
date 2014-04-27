# encoding: utf-8
require 'spec_helper'

describe Slide do
  before :each do
    Slide.clear
  end

  context '.create' do
    it 'creates slide instances' do
      file_path = create_file 'slide.html.erb'

      expect {
        Slide.create(file_path)
      }.not_to raise_error
    end
  end

  context '.load_from' do
    it 'loads slides from local directory' do
      dir = create_directory  'slides'

      create_file 'slides/01.html.erb', '<section></section>'
      create_file 'slides/02.html.erb', '<section></section>'
      create_file 'slides/03.html.erb', '<section></section>'

      expect {
        Slide.load_from(dir)
      }.not_to raise_error

      expect(Slide.count).to eq 3
    end
  end

  context '.all' do
    it 'returns all known instances' do
      f1 = create_file 'slides/01.html.erb', '<section></section>'
      f2 = create_file 'slides/02.html.erb', '<section></section>'

      Slide.create(f1)
      Slide.create(f2)

      expect(Slide.all.size).to eq 2
    end
  end

  context '#relative_path' do
    it 'path relative to base dir' do
      file = create_file 'slides/01.html.erb', '<section></section>'
      slide = Slide.new(file)

      expect(slide.relative_to_path(working_directory)).to eq 'slides/01.html.erb'
    end
  end

end
