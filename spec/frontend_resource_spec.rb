# encoding: utf-8
require 'spec_helper'

RSpec.describe FrontendComponent do
  context '#initialize' do
    it 'supports a full url as resource locator' do
      expect do
        FrontendComponent.new(resource_locator: 'http://www.example.org/test')
      end.not_to raise_error
    end

    it 'fails if neither github nor resource_locator is given' do
      expect do
        FrontendComponent.new
      end.to raise_error ArgumentError
    end

    it 'build github url' do
      expect do
        FrontendComponent.new(github: 'example/example')
      end.not_to raise_error
    end

    it 'fails if name is empty when extracted from url' do
      expect do
        FrontendComponent.new(resource_locator: 'http://www.example.org')
      end.to raise_error ArgumentError
    end

    it 'requires name if version is given' do
      expect do
        FrontendComponent.new(version: '1.1.1', name: 'blub')
      end.not_to raise_error
    end

    it 'fails if version is given but no name' do
      expect do
        FrontendComponent.new(version: '1.1.1')
      end.to raise_error ArgumentError
    end
  end

  context '#name' do
    it 'extracts name from url' do
      component = FrontendComponent.new(resource_locator: 'http://example.org/test')
      expect(component.name).to eq 'test'
    end

    it 'uses name' do
      component = FrontendComponent.new(resource_locator: 'http://example.org/test', name: 'name')
      expect(component.name).to eq 'name'
    end
  end

  context '.parse' do
    let(:hashes) do
      [
        {
          name: 'name',
          resource_locator: 'https://example.org/test',
          javascripts: [
            'path/to/file.js',
          ],
          stylesheets: [
            'path/to/file.scss',
          ],
        }
      ]
    end

    it 'reads data from array of hashes' do
      components = FrontendComponent.parse(hashes)
      expect(components.first.name).to eq 'name'
      expect(components.first.resource_locator).to eq 'https://example.org/test'
      expect(components.first.javascripts.first).to eq 'name/path/to/file.js'
      expect(components.first.stylesheets.first).to eq 'name/path/to/file.scss'
    end

    it 'reads data from hash' do
      components = FrontendComponent.parse(hashes.first)
      expect(components.first.name).to eq 'name'
      expect(components.first.resource_locator).to eq 'https://example.org/test'
      expect(components.first.javascripts.first).to eq 'name/path/to/file.js'
      expect(components.first.stylesheets.first).to eq 'name/path/to/file.scss'
    end
  end
end
