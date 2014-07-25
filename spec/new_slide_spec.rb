# encoding: utf-8
require 'spec_helper'

RSpec.describe NewSlide do

  context '#<=>' do

    it 'compares slides with same name' do
      slide1 = NewSlide.new(name: '01')
      slide2 = NewSlide.new(name: '01')

      expect(slide1).to eq slide2
    end

    it 'compares slides with different names but same basenames' do
      slide1 = NewSlide.new(name: '01.erb')
      slide2 = NewSlide.new(name: '01.md')

      expect(slide1).to eq slide2
    end

    it 'compares slides with different names but same basenames' do
      slide1 = NewSlide.new(name: '01.erb.erb.erb')
      slide2 = NewSlide.new(name: '01.md.erb.erb')

      expect(slide1).to eq slide2
    end

    it 'compares slides with different basenames' do
      slide1 = NewSlide.new(name: '01')
      slide2 = NewSlide.new(name: '02')

      expect(slide1).not_to eq slide2
    end
  end
end
