# encoding: utf-8
RSpec.describe Transformers::SortSlides do
  context '#transform' do
    it 'sorts slides' do
      slide1 = instance_double('Middleman::Presentation::Slide')
      allow(slide1).to receive(:file_name).and_return('01.html.erb')

      slide2 = instance_double('Middleman::Presentation::Slide')
      allow(slide2).to receive(:file_name).and_return('02.html.erb')

      slides = []
      slides << slide2
      slides << slide1

      slides = Transformers::SortSlides.new.transform(slides)
      expect(slides.first).to be slide1
    end
  end
end
