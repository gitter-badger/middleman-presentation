# encoding: utf-8
require 'spec_helper'

RSpec.describe Transformers::IgnoreSlides do
  context '#transform' do
    it 'ignores slides based on file name' do
      ignore_file = create_file '.slideignore', <<-EOS.strip_heredoc
      02.html.md
      EOS

      slide1 = Slide.new name: '01.html.erb'
      slide1.path = '01.html.erb'

      slide2 = Slide.new name: '02.html.md'
      slide2.path = '02.html.md'

      slide3 = Slide.new name: '03.html.md'
      slide3.path = '03.html.md'

      transformer = Transformers::IgnoreSlides.new ignore_file: ignore_file
      result = transformer.transform([slide1, slide2, slide3])

      expect(result).to include slide1
      expect(result).not_to include slide2
      expect(result).to include slide3
    end

    it 'unignores slides based on file name' do
      ignore_file = create_file '.slideignore', <<-EOS.strip_heredoc
      .md$
      !02.html.md
      EOS

      slide1 = Slide.new name: '01.html.erb'
      slide1.path = '01.html.erb'

      slide2 = Slide.new name: '02.html.md'
      slide2.path = '02.html.md'

      slide3 = Slide.new name: '03.html.md'
      slide3.path = '03.html.md'

      transformer = Transformers::IgnoreSlides.new ignore_file: ignore_file
      result = transformer.transform([slide1, slide2, slide3])

      expect(result).to include slide1
      expect(result).to include slide2
      expect(result).not_to include slide3
    end

    it 'handles non existing ignore file' do
      slide1 = Slide.new name: '01.html.erb'
      slide1.path = '01.html.erb'

      slide2 = Slide.new name: '02.html.md'
      slide2.path = '02.html.md'

      slide3 = Slide.new name: '03.html.md'
      slide3.path = '03.html.md'

      transformer = Transformers::IgnoreSlides.new ignore_file: SecureRandom.hex
      result = transformer.transform([slide1, slide2, slide3])

      expect(result).to include slide1
      expect(result).to include slide2
      expect(result).to include slide3
    end
  end
end
