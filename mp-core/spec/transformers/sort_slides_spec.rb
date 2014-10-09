# encoding: utf-8
require 'spec_helper'

RSpec.describe Transformers::SortSlides do
  context '#transform' do
    it 'sorts slides' do
      slides = []
      slides << 1
      slides << 3
      slides << 2

      slides = Transformers::SortSlides.new.transform(slides)
      expect(slides.first).to eq 1
      expect(slides.last).to eq 3
    end
  end
end
