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
    it 'sets the paths of erb slide' do
      base_path = 'path/to/slides'
      base_name = '01'
      file_name = "#{base_name}.html.erb"
      type      = :erb

      slide = instance_double('Middleman::Presentation::Slide')
      expect(slide).to receive(:has_extname?).with('.erb').and_return(true)
      expect(slide).to receive(:basename).twice.and_return(base_name)
      expect(slide).to receive(:partial_path=).with(File.join('slides', "#{base_name}.html"))
      expect(slide).to receive(:path=).with File.join(base_path, file_name)
      expect(slide).to receive(:type=).with type

      transformer = Transformers::SlidePath.new(base_path)
      transformer.transform [slide]
    end

    it 'sets the paths of markdown slide' do
      base_path = 'path/to/slides'
      base_name = '01'
      file_name = "#{base_name}.html.md"
      type      = :md

      slide = instance_double('Middleman::Presentation::Slide')
      allow(slide).to receive(:has_extname?).with('.erb').and_return(false)
      expect(slide).to receive(:has_extname?).with('.md', '.markdown', '.mkd').and_return(true)
      expect(slide).to receive(:basename).twice.and_return(base_name)
      expect(slide).to receive(:partial_path=).with(File.join('slides', "#{base_name}.html"))
      expect(slide).to receive(:path=).with File.join(base_path, file_name)
      expect(slide).to receive(:type=).with type

      transformer = Transformers::SlidePath.new(base_path)
      transformer.transform [slide]
    end

    it 'sets the paths of liquid slide' do
      base_path = 'path/to/slides'
      base_name = '01'
      file_name = "#{base_name}.html.liquid"
      type      = :liquid

      slide = instance_double('Middleman::Presentation::Slide')
      allow(slide).to receive(:has_extname?).with('.erb').and_return(false)
      allow(slide).to receive(:has_extname?).with('.md', '.markdown', '.mkd').and_return(false)
      allow(slide).to receive(:has_extname?).with('.l', '.liquid').and_return(true)
      expect(slide).to receive(:basename).twice.and_return(base_name)
      expect(slide).to receive(:partial_path=).with(File.join('slides', "#{base_name}.html"))
      expect(slide).to receive(:path=).with File.join(base_path, file_name)
      expect(slide).to receive(:type=).with type

      transformer = Transformers::SlidePath.new(base_path)
      transformer.transform [slide]
    end

    it 'sets the paths of unknown type slide' do
      base_path = 'path/to/slides'
      base_name = '01'
      file_name = "#{base_name}.html.md"
      type      = :md

      slide = instance_double('Middleman::Presentation::Slide')
      allow(slide).to receive(:has_extname?).and_return(false)
      expect(slide).to receive(:basename).twice.and_return(base_name)
      expect(slide).to receive(:partial_path=).with(File.join('slides', "#{base_name}.html"))
      expect(slide).to receive(:path=).with File.join(base_path, file_name)
      expect(slide).to receive(:type=).with type

      transformer = Transformers::SlidePath.new(base_path)
      transformer.transform [slide]
    end

    it 'handles names with multiple dots' do
      base_path = 'path/to/slides'
      base_name = '01.erb.asdf.md'
      file_name = "#{base_name}.html.md"
      type      = :md

      slide = instance_double('Middleman::Presentation::Slide')
      allow(slide).to receive(:has_extname?).and_return(false)
      expect(slide).to receive(:basename).twice.and_return(base_name)
      expect(slide).to receive(:partial_path=).with(File.join('slides', "#{base_name}.html"))
      expect(slide).to receive(:path=).with File.join(base_path, file_name)
      expect(slide).to receive(:type=).with type

      transformer = Transformers::SlidePath.new(base_path)
      transformer.transform [slide]
    end
  end
end
