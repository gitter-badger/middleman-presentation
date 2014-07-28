# encoding: utf-8
require 'spec_helper'

RSpec.describe Transformers::RemoveDuplicateSlides do
  context '#transform' do
    it 'removes similar slides: same basename but different file name' do
      slide1 = Slide.new name: '01.html.erb'
      slide1.file_name = '01.html.erb'

      slide2 = Slide.new name: '01.html.md'
      slide2.file_name = '01.html.md'

      slide3 = Slide.new name: '02.html.md'
      slide3.file_name = '02.html.md'

      transformer = Transformers::RemoveDuplicateSlides.new
      result = transformer.transform([slide1, slide2, slide3])

      expect(result).not_to include slide1
      expect(result).not_to include slide2
      expect(result).to include slide3
    end

    it 'raises an error on similar slides' do
      slide1 = Slide.new name: '01.html.erb'
      slide1.file_name = '01.html.erb'

      slide2 = Slide.new name: '01.html.md'
      slide2.file_name = '01.html.md'

      transformer = Transformers::RemoveDuplicateSlides.new raise_error: true

      expect {
        transformer.transform([slide1, slide2])
      }.to raise_error ArgumentError
    end

    it 'considers additional slides which will be not part of the output' do
      slide1 = Slide.new name: '01.html.erb'
      slide1.file_name = '01.html.erb'

      slide2 = Slide.new name: '01.html.md'
      slide2.file_name = '01.html.md'

      slide3 = Slide.new name: '02.html.md'
      slide3.file_name = '02.html.md'

      slide4 = Slide.new name: '03.html.md'
      slide4.file_name = '03.html.md'

      transformer = Transformers::RemoveDuplicateSlides.new additional_slides: [slide2, slide4]
      result = transformer.transform([slide1, slide3])

      expect(result).not_to include slide1
      expect(result).not_to include slide2
      expect(result).not_to include slide4
      expect(result).to include slide3
    end

  end
end
