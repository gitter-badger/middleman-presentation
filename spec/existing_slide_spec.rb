# encoding: utf-8
require 'spec_helper'

RSpec.describe ExistingSlide do

  context '#<=>' do
    it 'compares slides with same file name' do
      slide1 = ExistingSlide.new('01.html.md')
      slide2 = ExistingSlide.new('01.html.md')

      expect(slide1).to eq slide2
    end

    it 'compares slides with different file names' do
      slide1 = ExistingSlide.new('01.html.erb')
      slide2 = ExistingSlide.new('01.html.md')

      expect(slide1).not_to eq slide2
    end
  end

  context '#eql?' do
    it 'succeeds on eqal file names' do
      slide1 = ExistingSlide.new('01.html.erb')
      slide2 = ExistingSlide.new('01.html.erb')

      expect(slide1.eql?(slide2)).to be_truthy
    end

    it 'fails on different names' do
      slide1 = ExistingSlide.new('01.html.erb')
      slide2 = ExistingSlide.new('02.html.erb')

      expect(slide1.eql?(slide2)).to be_falsey
    end
  end

  context '#similar?' do
    it 'succeeds if both files share the same base name' do
      slide1 = ExistingSlide.new('01.html.erb')
      slide2 = ExistingSlide.new('01.html.md')

      expect(slide1).to be_similar slide2
    end

    it 'fails if both files do not share the same basename' do
      slide1 = ExistingSlide.new('01.html.erb')
      slide2 = ExistingSlide.new('02.html.erb')

      expect(slide1).not_to be_similar slide2
    end
  end

  context '#hash' do
    it 'generates hash based on file name' do
      slide = ExistingSlide.new('01.html.erb')
      expect(slide).to respond_to :hash
    end
  end

  context '#content' do
    it 'evaluates given template with data' do
      file = create_file '01.html.erb', <<-EOS.strip_heredoc
      world
      EOS
      slide = ExistingSlide.new(file)

      expect(slide.content).to eq 'world'
    end
  end

  context '#exist?' do
    it 'succeeds if slide file exists in filesystem' do
      file = create_file '02.html.md'
      slide = ExistingSlide.new(file)

      expect(slide).to be_exist
    end

    it 'fails if slide file does not exists in filesystem' do
      slide = ExistingSlide.new(SecureRandom.hex)

      expect(slide).not_to be_exist
    end
  end

  #context '#type?' do
  #  it 'checks on a single file extension' do
  #    slide = ExistingSlide.new('02')
  #    slide.path = '02.html.md'
  #    expect(slide).to be_type :md
  #  end

  #  it 'fails if has not type' do
  #    slide = ExistingSlide.new('02')
  #    slide.path = '02.html.erb'
  #    expect(slide).not_to be_type :md
  #  end
  #end

  context '#to_s' do
    it 'returns string representation of self' do
      slide = ExistingSlide.new('02.html.md')

      expect(slide.to_s).to eq '02.html.md'
    end
  end

  context '#basename' do
    it 'reduces slide file name to minimum' do
      slide = ExistingSlide.new(File.join(working_directory, '02.html.erb'))
      expect(slide.base_name).to eq '02'
    end
  end

  context '#match?' do
    it 'matches full path' do
      slide = ExistingSlide.new(File.join(working_directory, '02.html.md'))

      expect(slide).to be_match(/02/)
    end

    it 'supports string' do
      slide = ExistingSlide.new(File.join(working_directory, '02.html.md'))

      expect(slide).to be_match('02')
    end
  end

  context '#group?' do
    it 'succeeds if slide has group' do
      slide = ExistingSlide.new(File.join(working_directory, 'source', 'slides', 'group', '02.html.md'), base_path: File.join(working_directory, 'source'))

      expect(slide).to be_group 'group'
    end

    it 'fails if slide has not group' do
      slide = ExistingSlide.new(File.join(working_directory, 'source', 'slides', '02.html.md'), base_path: File.join(working_directory, 'source'))

      expect(slide).not_to be_group 'group'
    end
  end

  context '#partial_path' do
    it 'returns path based on base without extensions' do
      slide = ExistingSlide.new(File.join(working_directory, 'slides', '02.html.md'), base_path: working_directory)

      expect(slide.partial_path).to eq Pathname.new('slides/02')
    end
  end
end
