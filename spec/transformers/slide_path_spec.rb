# encoding: utf-8
require 'spec_helper'

RSpec.describe Transformers::SlidePath do
  context '#initialize' do 
    it 'requires a base directory' do
      expect {
        Transformers::SlidePath.new(base_path: 'path')
      }.not_to raise_error
    end
  end

  context '#transform' do
    it 'sets the path of slide' do
      base_path = 'path'
      file_name = '01.html.erb'

      slide = instance_double('Middleman::Presentation::NewSlide')
      expect(slide).to receive(:file_name).and_return file_name
      expect(slide).to receive(:path=).with File.join(base_path, file_name)

      transformer = Transformers::SlidePath.new('path')
      transformer.transform slide
    end
  end
end
