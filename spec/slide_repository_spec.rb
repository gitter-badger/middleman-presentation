# encoding: utf-8
require 'spec_helper'

describe SlideRepository do
  context '#add' do
    it 'add slide instances' do
      file_path = create_file 'slide.html.erb'

      creator = double('Slide')
      expect(creator).to receive(:new)

      repo = SlideRepository.new
      repo.add(file_path, creator)
    end
  end

  context '#initialize' do
    it 'loads slides from local directory' do
      dir = create_directory  'slides'

      create_file 'slides/01.html.erb', '<section></section>'
      create_file 'slides/02.html.erb', '<section></section>'
      create_file 'slides/03.html.erb', '<section></section>'

      repo = SlideRepository.new(dir)

      expect(repo.count).to eq 3
    end
  end

  context '#all' do
    it 'returns all known instances' do
      f1 = create_file 'slides/01.html.erb', '<section></section>'
      f2 = create_file 'slides/02.html.erb', '<section></section>'

      repo = SlideRepository.new
      repo.add(f1)
      repo.add(f2)

      expect(repo.all.size).to eq 2
    end
  end
end
