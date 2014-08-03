# encoding: utf-8
require 'spec_helper'

RSpec.describe Transformers::SlidePath do
  context '#initialize' do
    it 'requires a base directory' do
      expect do
        Transformers::SlidePath.new(base_path: 'path')
      end.not_to raise_error
    end
  end

  context '#transform' do
    it 'sets the paths of erb slide' do
      base_path = File.expand_path('source/slides')
      base_name = '01'
      file_name = "#{base_name}.html.erb"

      slide = instance_double('Middleman::Presentation::Slide')
      expect(slide).to receive(:has_type?).with(:erb).and_return(true)
      allow(slide).to receive(:has_type?).and_return(false)
      allow(slide).to receive(:basename).twice.and_return(base_name)
      expect(slide).to receive(:file_name).and_return(file_name)
      allow(slide).to receive(:group).and_return nil
      expect(slide).to receive(:partial_path=).with(File.join('slides', '01'))
      expect(slide).to receive(:relative_path=).with(File.join(File.basename(File.dirname(base_path)), File.basename(base_path), file_name))
      expect(slide).to receive(:path=).with File.join(base_path, file_name)

      transformer = Transformers::SlidePath.new(base_path)
      transformer.transform [slide]
    end

    it 'sets the paths of markdown slide' do
      base_path = File.expand_path('source/slides')
      base_name = '01'
      file_name = "#{base_name}.html.md"

      slide = instance_double('Middleman::Presentation::Slide')
      expect(slide).to receive(:file_name).and_return(file_name)
      expect(slide).to receive(:has_type?).with(:md).and_return(true)
      allow(slide).to receive(:has_type?).and_return(false)
      allow(slide).to receive(:basename).twice.and_return(base_name)
      allow(slide).to receive(:group).and_return nil
      expect(slide).to receive(:partial_path=).with(File.join('slides', '01'))
      expect(slide).to receive(:relative_path=).with(File.join(File.basename(File.dirname(base_path)), File.basename(base_path), file_name))
      expect(slide).to receive(:path=).with File.join(base_path, file_name)

      transformer = Transformers::SlidePath.new(base_path)
      transformer.transform [slide]
    end

    it 'sets the paths of liquid slide' do
      base_path = File.expand_path('source/slides')
      base_name = '01'
      file_name = "#{base_name}.html.liquid"

      slide = instance_double('Middleman::Presentation::Slide')
      expect(slide).to receive(:file_name).and_return(file_name)
      expect(slide).to receive(:has_type?).with(:liquid).and_return(true)
      allow(slide).to receive(:has_type?).and_return(false)
      allow(slide).to receive(:basename).twice.and_return(base_name)
      allow(slide).to receive(:group).and_return nil
      expect(slide).to receive(:partial_path=).with(File.join('slides', '01'))
      expect(slide).to receive(:relative_path=).with(File.join(File.basename(File.dirname(base_path)), File.basename(base_path), file_name))
      expect(slide).to receive(:path=).with File.join(base_path, file_name)

      transformer = Transformers::SlidePath.new(base_path)
      transformer.transform [slide]
    end

    it 'sets the paths of unknown type slide' do
      base_path = File.expand_path('source/slides')
      base_name = '01'
      file_name = "#{base_name}.html.md"

      slide = instance_double('Middleman::Presentation::Slide')
      expect(slide).to receive(:file_name).and_return(file_name)
      allow(slide).to receive(:has_type?).and_return(false)
      allow(slide).to receive(:basename).twice.and_return(base_name)
      allow(slide).to receive(:group).and_return nil
      expect(slide).to receive(:partial_path=).with(File.join('slides', '01'))
      expect(slide).to receive(:relative_path=).with(File.join(File.basename(File.dirname(base_path)), File.basename(base_path), file_name))
      expect(slide).to receive(:path=).with File.join(base_path, file_name)

      transformer = Transformers::SlidePath.new(base_path)
      transformer.transform [slide]
    end

    it 'handles group for partial path and full path' do
      base_path = File.expand_path('source/slides')
      base_name = '01'
      file_name = "#{base_name}.html.md"

      slide = instance_double('Middleman::Presentation::Slide')
      expect(slide).to receive(:file_name).and_return(file_name)
      allow(slide).to receive(:has_type?).and_return(false)
      allow(slide).to receive(:basename).twice.and_return(base_name)
      allow(slide).to receive(:group).and_return 'group'
      expect(slide).to receive(:partial_path=).with(File.join('slides', 'group', '01'))
      expect(slide).to receive(:relative_path=).with(File.join(File.basename(File.dirname(base_path)), File.basename(base_path), 'group', file_name))
      expect(slide).to receive(:path=).with File.join(base_path, 'group', file_name)

      transformer = Transformers::SlidePath.new(base_path)
      transformer.transform [slide]
    end
  end
end
