# encoding: utf-8
require 'spec_helper'

RSpec.describe Transformers::ReadContent do
  context '#transform' do
    it 'reads file content if file exists' do
      slide = instance_double('Middleman::Presentation::Slide')
      expect(slide).to receive(:path).and_return create_file('01.html.md', 'Hello World')
      expect(slide).to receive(:content=).with 'Hello World'
      expect(slide).to receive(:exist?).and_return true

      transformer = Transformers::ReadContent.new
      transformer.transform [slide]
    end

    it 'reads nothing content if does not exist' do
      slide = instance_double('Middleman::Presentation::Slide')
      expect(slide).not_to receive(:content=)
      expect(slide).to receive(:exist?).and_return false

      transformer = Transformers::ReadContent.new
      transformer.transform [slide]
    end
  end
end
