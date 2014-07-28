# encoding: utf-8
require 'spec_helper'

RSpec.describe Transformers::TemplateFinder do
  context '#initialize' do 
    it 'requires a base directory' do
      expect {
        Transformers::TemplateFinder.new
      }.not_to raise_error
    end
  end

  context '#transform' do
    it 'sets file name to <>.html.erb if no extension is given' do
      slide = instance_double('Middleman::Presentation::Slide')
      allow(slide).to receive(:name).and_return '01'
      allow(slide).to receive(:extname).and_return nil
      expect(slide).to receive(:template=).with(kind_of(Erubis::Eruby))
      expect(slide).to receive(:file_name=).with "01.html.erb"
      expect(slide).to receive(:type).and_return :erb

      transformer = Transformers::TemplateFinder.new
      transformer.transform [slide]
    end

    it 'sets file name to <>.html.erb if extension is erb' do
      slide = instance_double('Middleman::Presentation::Slide')
      allow(slide).to receive(:name).and_return '01'
      allow(slide).to receive(:extname).and_return '.erb'
      expect(slide).to receive(:template=).with(kind_of(Erubis::Eruby))
      expect(slide).to receive(:file_name=).with "01.html.erb"
      expect(slide).to receive(:type).and_return :erb

      transformer = Transformers::TemplateFinder.new
      transformer.transform [slide]
    end

    it 'sets file name to <>.html.md if extension is md' do
      slide = instance_double('Middleman::Presentation::Slide')
      allow(slide).to receive(:name).and_return '01'
      allow(slide).to receive(:extname).and_return '.md'
      expect(slide).to receive(:template=).with(kind_of(Erubis::Eruby))
      expect(slide).to receive(:file_name=).with "01.html.md"
      expect(slide).to receive(:type).and_return :md

      transformer = Transformers::TemplateFinder.new
      transformer.transform [slide]
    end

    it 'sets file name to <>.html.md if extension is markdown' do
      slide = instance_double('Middleman::Presentation::Slide')
      allow(slide).to receive(:name).and_return '01'
      allow(slide).to receive(:extname).and_return '.markdown'
      expect(slide).to receive(:template=).with(kind_of(Erubis::Eruby))
      expect(slide).to receive(:file_name=).with "01.html.md"
      expect(slide).to receive(:type).and_return :md

      transformer = Transformers::TemplateFinder.new
      transformer.transform [slide]
    end

    it 'sets file name to <>.html.liquid if extension is l' do
      slide = instance_double('Middleman::Presentation::Slide')
      allow(slide).to receive(:name).and_return '01'
      allow(slide).to receive(:extname).and_return '.l'
      expect(slide).to receive(:template=).with(kind_of(Erubis::Eruby))
      expect(slide).to receive(:file_name=).with "01.html.liquid"
      expect(slide).to receive(:type).and_return :liquid

      transformer = Transformers::TemplateFinder.new
      transformer.transform [slide]
    end

    it 'sets file name to <>.html.liquid if extension is liquid' do
      slide = instance_double('Middleman::Presentation::Slide')
      allow(slide).to receive(:name).and_return '01'
      allow(slide).to receive(:extname).and_return '.liquid'
      expect(slide).to receive(:template=).with(kind_of(Erubis::Eruby))
      expect(slide).to receive(:file_name=).with "01.html.liquid"
      expect(slide).to receive(:type).and_return :liquid

      transformer = Transformers::TemplateFinder.new
      transformer.transform [slide]
    end
  end
end
