# encoding: utf-8
require 'spec_helper'

RSpec.describe NewSlide do

  context '#<=>' do
    it 'compares slides with same file name' do
      slide1 = NewSlide.new('01.md', base_path: File.join(working_directory, 'source', 'slides'))
      slide2 = NewSlide.new('01.md', base_path: File.join(working_directory, 'source', 'slides'))

      expect(slide1).to eq slide2
    end

    it 'compares slides with different file names' do
      slide1 = NewSlide.new('01.erb', base_path: File.join(working_directory, 'source', 'slides'))
      slide2 = NewSlide.new('01.md', base_path: File.join(working_directory, 'source', 'slides'))

      expect(slide1).not_to eq slide2
    end

    it 'compares slides with not extension at all' do
      slide1 = NewSlide.new('01', base_path: File.join(working_directory, 'source', 'slides'))
      slide2 = NewSlide.new('01', base_path: File.join(working_directory, 'source', 'slides'))

      expect(slide1).to eq slide2
    end
  end

  context '#eql?' do
    it 'succeeds on eqal file names' do
      slide1 = NewSlide.new('01.erb', base_path: File.join(working_directory, 'source', 'slides'))
      slide2 = NewSlide.new('01.erb', base_path: File.join(working_directory, 'source', 'slides'))

      expect(slide1.eql?(slide2)).to be_truthy
    end

    it 'fails on different names' do
      slide1 = NewSlide.new('01.erb', base_path: File.join(working_directory, 'source', 'slides'))
      slide2 = NewSlide.new('02.erb', base_path: File.join(working_directory, 'source', 'slides'))

      expect(slide1.eql?(slide2)).to be_falsey
    end
  end

  context '#similar?' do
    it 'succeeds if both files share the same basename' do
      slide1 = NewSlide.new('01.erb', base_path: File.join(working_directory, 'source', 'slides'))
      slide2 = NewSlide.new('01.md', base_path: File.join(working_directory, 'source', 'slides'))

      expect(slide1).to be_similar slide2
    end

    it 'fails if both files do not share the same basename' do
      slide1 = NewSlide.new('01.erb', base_path: File.join(working_directory, 'source', 'slides'))
      slide2 = NewSlide.new('02.erb', base_path: File.join(working_directory, 'source', 'slides'))

      expect(slide1).not_to be_similar slide2
    end
  end

  context '#hash' do
    it 'generates hash based on file name' do
      slide = NewSlide.new('01.erb', base_path: File.join(working_directory, 'source', 'slides'))
      expect(slide).to respond_to :hash
    end
  end

  context '#content' do
    it 'evaluates template with data' do
      slide = NewSlide.new('01.erb', base_path: File.join(working_directory, 'source', 'slides'))

      expect(slide.content(title: 'world')).to eq <<-EOS.strip_heredoc.chomp
      <section>
        <h1>
          world
        </h1>
      </section>
      EOS
    end
  end

  context '#to_s' do
    it 'returns string representation of self' do
      slide = NewSlide.new('02.md', base_path: File.join(working_directory, 'source', 'slides'))

      expect(slide.to_s).to eq File.join(working_directory, 'source', 'slides', '02.html.md')
    end
  end

  context '#basename' do
    it 'reduces slide file name to minimum' do
      slide = NewSlide.new('02.erb', base_path: File.join(working_directory, 'source', 'slides'))
      expect(slide.base_name).to eq '02'
    end
  end

  context '#match?' do
    it 'matches relative path' do
      slide = NewSlide.new('02.md', base_path: File.join(working_directory, 'source', 'slides'))

      expect(slide).to be_match(/02/)
    end

    it 'supports string' do
      slide = NewSlide.new('02.md', base_path: File.join(working_directory, 'source', 'slides'))

      expect(slide).to be_match('02')
    end
  end

  context '#group?' do
    it 'succeeds if slide has group' do
      slide = NewSlide.new('group:02.md', base_path: File.join(working_directory, 'source', 'slides'))

      expect(slide).to be_group 'group'
    end

    it 'succeeds if slide has group and no ending' do
      slide = NewSlide.new('group:02', base_path: File.join(working_directory, 'source', 'slides'))

      expect(slide).to be_group 'group'
    end

    it 'succeeds if slide has same name for group and slide' do
      slide = NewSlide.new('02:02', base_path: File.join(working_directory, 'source', 'slides'))

      expect(slide).to be_group '02'
    end

    it 'fails if slide has not group' do
      slide = NewSlide.new('02.md', base_path: File.join(working_directory, 'source'))

      expect(slide).not_to be_group 'group'
    end
  end
end
