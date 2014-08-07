# encoding: utf-8
require 'spec_helper'

RSpec.describe Transformers::FileKeeper do
  context '#transform' do
    it 'removes directories from array and keep files' do

      slide1 = instance_double('Middleman::Presentation::NewSlide')
      allow(slide1).to receive(:path).and_return create_file('01.html.erb')

      slide2 = instance_double('Middleman::Presentation::NewSlide')
      allow(slide2).to receive(:path).and_return create_directory('01_dir')

      slides = []
      slides << slide2
      slides << slide1

      slides = Transformers::FileKeeper.new.transform(slides)
      expect(slides).to include slide1
      expect(slides).not_to include slide2
    end
  end
end
