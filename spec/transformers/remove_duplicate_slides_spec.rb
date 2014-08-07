# encoding: utf-8
require 'spec_helper'

RSpec.describe Transformers::RemoveDuplicateSlides do
  context '#transform' do
    it 'removes similar slides: same basename but different file name' do
      slide1 = instance_double('Middleman::Presentation::ExistingSlide')
      slide2 = instance_double('Middleman::Presentation::ExistingSlide')
      slide3 = instance_double('Middleman::Presentation::ExistingSlide')

      allow(slide1).to receive(:eql?).with(slide1).and_return(true)
      allow(slide1).to receive(:eql?).with(slide2).and_return(false)
      allow(slide1).to receive(:eql?).with(slide3).and_return(false)
      allow(slide1).to receive(:similar?).with(slide1).and_return(false)
      allow(slide1).to receive(:similar?).with(slide2).and_return(true)
      allow(slide1).to receive(:similar?).with(slide3).and_return(false)

      allow(slide2).to receive(:eql?).with(slide1).and_return(false)
      allow(slide2).to receive(:eql?).with(slide2).and_return(true)
      allow(slide2).to receive(:eql?).with(slide3).and_return(false)
      allow(slide2).to receive(:similar?).with(slide1).and_return(true)
      allow(slide2).to receive(:similar?).with(slide2).and_return(false)
      allow(slide2).to receive(:similar?).with(slide3).and_return(false)

      allow(slide3).to receive(:eql?).with(slide1).and_return(false)
      allow(slide3).to receive(:eql?).with(slide2).and_return(false)
      allow(slide3).to receive(:eql?).with(slide3).and_return(true)
      allow(slide3).to receive(:similar?).with(slide1).and_return(false)
      allow(slide3).to receive(:similar?).with(slide2).and_return(false)
      allow(slide3).to receive(:similar?).with(slide3).and_return(false)

      transformer = Transformers::RemoveDuplicateSlides.new
      result      = transformer.transform([slide1, slide2, slide3])

      expect(result).not_to include slide1
      expect(result).not_to include slide2
      expect(result).to include slide3
    end

    it 'raises an error on similar slides' do
      slide1 = instance_double('Middleman::Presentation::ExistingSlide')
      slide2 = instance_double('Middleman::Presentation::ExistingSlide')

      allow(slide1).to receive(:eql?).with(slide1).and_return(false)
      allow(slide1).to receive(:eql?).with(slide2).and_return(false)
      allow(slide1).to receive(:file_name).and_return('01.html.erb')
      allow(slide1).to receive(:similar?).with(slide1).and_return(true)
      allow(slide1).to receive(:similar?).with(slide2).and_return(true)

      allow(slide2).to receive(:eql?).with(slide1).and_return(false)
      allow(slide2).to receive(:eql?).with(slide2).and_return(false)
      allow(slide2).to receive(:file_name).and_return('01.html.md')
      allow(slide2).to receive(:similar?).with(slide1).and_return(true)
      allow(slide2).to receive(:similar?).with(slide2).and_return(true)

      transformer = Transformers::RemoveDuplicateSlides.new raise_error: true

      expect do
        transformer.transform([slide1, slide2])
      end.to raise_error ArgumentError
    end

    it 'considers additional slides which will be not part of the output' do
      slide1 = instance_double('Middleman::Presentation::ExistingSlide')
      slide2 = instance_double('Middleman::Presentation::ExistingSlide')
      slide3 = instance_double('Middleman::Presentation::ExistingSlide')
      slide4 = instance_double('Middleman::Presentation::ExistingSlide')

      allow(slide1).to receive(:file_name).and_return '01.html.erb'
      allow(slide1).to receive(:eql?).with(slide1).and_return(true)
      allow(slide1).to receive(:eql?).with(slide2).and_return(true)
      allow(slide1).to receive(:eql?).with(slide3).and_return(false)
      allow(slide1).to receive(:eql?).with(slide4).and_return(false)
      allow(slide1).to receive(:similar?).with(slide1).and_return(false)
      allow(slide1).to receive(:similar?).with(slide2).and_return(true)
      allow(slide1).to receive(:similar?).with(slide3).and_return(false)
      allow(slide1).to receive(:similar?).with(slide4).and_return(false)

      allow(slide2).to receive(:file_name).and_return '01.html.md'
      allow(slide2).to receive(:eql?).with(slide1).and_return(false)
      allow(slide2).to receive(:eql?).with(slide2).and_return(true)
      allow(slide2).to receive(:eql?).with(slide3).and_return(false)
      allow(slide2).to receive(:eql?).with(slide4).and_return(false)
      allow(slide2).to receive(:similar?).with(slide1).and_return(true)
      allow(slide2).to receive(:similar?).with(slide2).and_return(false)
      allow(slide2).to receive(:similar?).with(slide3).and_return(false)
      allow(slide2).to receive(:similar?).with(slide4).and_return(false)

      allow(slide2).to receive(:file_name).and_return '02.html.md'
      allow(slide3).to receive(:eql?).with(slide1).and_return(false)
      allow(slide3).to receive(:eql?).with(slide2).and_return(false)
      allow(slide3).to receive(:eql?).with(slide3).and_return(true)
      allow(slide3).to receive(:eql?).with(slide4).and_return(false)
      allow(slide3).to receive(:similar?).with(slide1).and_return(false)
      allow(slide3).to receive(:similar?).with(slide2).and_return(false)
      allow(slide3).to receive(:similar?).with(slide3).and_return(false)
      allow(slide3).to receive(:similar?).with(slide4).and_return(false)

      allow(slide2).to receive(:file_name).and_return '03.html.md'
      allow(slide4).to receive(:eql?).with(slide1).and_return(false)
      allow(slide4).to receive(:eql?).with(slide2).and_return(false)
      allow(slide4).to receive(:eql?).with(slide3).and_return(false)
      allow(slide4).to receive(:eql?).with(slide4).and_return(true)
      allow(slide4).to receive(:similar?).with(slide1).and_return(false)
      allow(slide4).to receive(:similar?).with(slide2).and_return(false)
      allow(slide4).to receive(:similar?).with(slide3).and_return(false)
      allow(slide4).to receive(:similar?).with(slide4).and_return(false)

      transformer = Transformers::RemoveDuplicateSlides.new additional_slides: [slide2, slide4]
      result = transformer.transform([slide1, slide3])

      # slide1 cannot be part of output
      # because a similar slide already exists
      expect(result).not_to include slide1
      expect(result).not_to include slide2
      expect(result).not_to include slide4
      expect(result).to include slide3
    end
  end
end
