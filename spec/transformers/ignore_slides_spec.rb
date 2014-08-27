# encoding: utf-8
require 'spec_helper'

RSpec.describe Transformers::IgnoreSlides do
  context '#transform' do
    it 'ignores slides based on file name' do
      ignore_file = write_file '.slidesignore', <<-EOS.strip_heredoc
      02.html.md
      EOS

      slide1 = instance_double('Middleman::Presentation::ExistingSlide')
      allow(slide1).to receive(:match?).and_return(false)

      slide2 = instance_double('Middleman::Presentation::ExistingSlide')
      allow(slide2).to receive(:match?).and_return(false)
      allow(slide2).to receive(:match?).with(/(?-mix:^!$)|(?-mix:02.html.md)/).and_return(true)

      transformer = Transformers::IgnoreSlides.new ignore_file: absolute_path(ignore_file)
      result = transformer.transform([slide1, slide2])

      expect(result).to include slide1
      expect(result).not_to include slide2
    end

    it 'unignores slides based on file name' do
      ignore_file = write_file '.slidesignore', <<-EOS.strip_heredoc
      .md$
      !02.html.md
      EOS

      slide1 = instance_double('Middleman::Presentation::ExistingSlide')
      allow(slide1).to receive(:match?).with(/(?-mix:^!$)|(?-mix:.md$)/).and_return(false)
      allow(slide1).to receive(:match?).with(/(?-mix:^!$)|(?-mix:02.html.md)/).and_return(true)

      slide2 = instance_double('Middleman::Presentation::ExistingSlide')
      allow(slide2).to receive(:match?).with(/(?-mix:^!$)|(?-mix:.md$)/).and_return(true)
      allow(slide2).to receive(:match?).with(/(?-mix:^!$)|(?-mix:02.html.md)/).and_return(true)

      slide3 = instance_double('Middleman::Presentation::ExistingSlide')
      allow(slide3).to receive(:match?).with(/(?-mix:^!$)|(?-mix:.md$)/).and_return(true)
      allow(slide3).to receive(:match?).with(/(?-mix:^!$)|(?-mix:02.html.md)/).and_return(false)

      transformer = Transformers::IgnoreSlides.new ignore_file: absolute_path(ignore_file)
      result = transformer.transform([slide1, slide2, slide3])

      expect(result).to include slide1
      expect(result).to include slide2
      expect(result).not_to include slide3
    end

    it 'handles non existing ignore file' do
      slide1 = instance_double('Middleman::Presentation::ExistingSlide')
      slide2 = instance_double('Middleman::Presentation::ExistingSlide')
      slide3 = instance_double('Middleman::Presentation::ExistingSlide')

      transformer = Transformers::IgnoreSlides.new ignore_file: SecureRandom.hex
      result = transformer.transform([slide1, slide2, slide3])

      expect(result).to include slide1
      expect(result).to include slide2
      expect(result).to include slide3
    end
  end
end
