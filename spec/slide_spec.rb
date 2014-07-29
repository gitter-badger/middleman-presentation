# encoding: utf-8
require 'spec_helper'

RSpec.describe Slide do

  context '#<=>' do
    it 'compares slides with same file name' do
      slide1 = Slide.new(name: '01.md')
      slide1.path = '01.html.md'

      slide2 = Slide.new(name: '01.md')
      slide2.path = '01.html.md'

      expect(slide1).to eq slide2
    end

    it 'compares slides with different file names' do
      slide1 = Slide.new(name: '01.erb')
      slide1.path = '01.html.erb'

      slide2 = Slide.new(name: '01.md')
      slide2.path = '01.html.md'

      expect(slide1).not_to eq slide2
    end
  end

  context '#eql?' do
    it 'succeeds on eqal file names' do
      slide1 = Slide.new(name: '01')
      slide1.path = '01.html.erb'
      slide2 = Slide.new(name: '01')
      slide2.path = '01.html.erb'

      expect(slide1.eql?(slide2)).to be_truthy
    end

    it 'fails on different names' do
      slide1 = Slide.new(name: '01')
      slide1.path = '01.html.erb'
      slide2 = Slide.new(name: '02')
      slide2.path = '02.html.erb'

      expect(slide1.eql?(slide2)).to be_falsey
    end
  end

  context '#similar?' do
    it 'succeeds if both files share the same basename' do
      slide1 = Slide.new(name: '01')
      slide2 = Slide.new(name: '01')

      expect(slide1).to be_similar slide2
    end

    it 'fails if both files do not share the same basename' do
      slide1 = Slide.new(name: '01')
      slide2 = Slide.new(name: '02')

      expect(slide1).not_to be_similar slide2
    end
  end

  context '#hash' do
    it 'generates hash based on file name' do
      slide = Slide.new(name: '01')
      expect(slide).to respond_to :hash
    end
  end
  
  context '#content' do
    it 'evaluates given template with data' do
      slide = Slide.new(name: '02')
      slide.path     = File.join(working_directory, '02.html.md')
      slide.template = Erubis::Eruby.new('<%= hello %>')
      expect(slide.content(hello: 'world')).to eq 'world'
    end

    it 'returns content if content was set without evaluating a given template' do
      slide = Slide.new(name: '02')
      slide.path     = File.join(working_directory, '02.html.md')
      slide.template = Erubis::Eruby.new('<%= hello %>')
      slide.content  = 'moon'

      expect(slide.content(hello: 'world')).to eq 'moon'
    end
  end

  context '#write' do
    it 'writes to path given by path' do
      slide = Slide.new(name: '02')

      slide.path     = File.join(working_directory, '02.html.md')
      slide.template = Erubis::Eruby.new('<%= hello %>')

      slide.write(hello: 'world')

      expect(read_file('02.html.md')).to eq 'world'
    end
  end

  context '#exist?' do
    it 'succeeds if slide file exists in filesystem' do
      create_file '02.html.md'

      slide = Slide.new(name: '02')
      slide.path     = File.join(working_directory, '02.html.md')

      expect(slide).to be_exist
    end

    it 'fails if slide file does not exists in filesystem' do
      slide = Slide.new(name: '02')
      slide.path     = File.join(working_directory, '02.html.md')

      expect(slide).not_to be_exist
    end

    it 'fails if slide file path is not set' do
      slide = Slide.new(name: '02')

      expect(slide).not_to be_exist
    end
  end

  context '#extname' do
    it 'returns file extension' do
      slide = Slide.new(name: '02')
      slide.path = '02.html.erb'
      expect(slide.extname).to eq '.erb'
    end

    it 'returns empty string if file name is not set' do
      slide = Slide.new(name: '02')
      expect(slide.extname).to eq ''
    end

    it 'returns file extension considering name as well' do
      slide = Slide.new(name: '02.erb')
      expect(slide.extname).to eq '.erb'
    end
  end

  context '#extname?' do
    it 'checks on a single file extension' do
      slide = Slide.new(name: '02')
      slide.path = '02.html.erb'
      expect(slide).to have_extname '.erb'
    end

    it 'checks on multiple file extensions' do
      slide = Slide.new(name: '02')
      slide.path = '02.html.erb'
      expect(slide).not_to have_extname '.xz', '.ab'
    end

    it 'succeeds if one the extensions is successfull' do
      slide = Slide.new(name: '02')
      slide.path = '02.html.erb'
      expect(slide).to have_extname '.xz', '.erb'
    end
  end

  context '#to_s' do
    it 'returns string representation of self' do
      slide = Slide.new(name: '02')
      slide.path = File.join(working_directory, '02.html.md')
      expect(slide.to_s).to eq File.join(working_directory, '02.html.md')
    end
  end

  context '#basename' do
    it 'reduces slide file name to minimum' do
      slide = Slide.new(name: '02')
      slide.path = File.join(working_directory, '02.html.md')
      expect(slide.basename).to eq '02'
    end
  end

  context '#match?' do
    it 'matches full path' do
      slide = Slide.new(name: '02')
      slide.path = File.join(working_directory, '02.html.md')

      expect(slide).to be_match(/02/)
    end

    it 'supports string' do
      slide = Slide.new(name: '02')
      slide.path = File.join(working_directory, '02.html.md')

      expect(slide).to be_match('02')
    end
  end

end
