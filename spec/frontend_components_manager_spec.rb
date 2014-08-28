# encoding: utf-8
require 'spec_helper'

RSpec.describe FrontendComponentsManager do
  let(:creator_stub) { Class.new }
  let(:creator) { stub_const('Middleman::Presentation::FrontendComponent', creator_stub) }

  context '#add' do
    it 'adds a hash to component list' do
      expect(creator).to receive(:new).with(
        name: 'test1',
        resource_locator: 'http://www.example.com',
        version: '0.0.1',
        javascripts: [],
        stylesheets: []
      )

      manager = FrontendComponentsManager.new(creator: creator)
      manager.add(
        name: 'test1',
        resource_locator: 'http://www.example.com',
        version: '0.0.1',
        javascripts: [],
        stylesheets: []
      )
    end

    it 'adds a struct to component list' do
      expect(creator).to receive(:new).with(
        name: 'test1',
        resource_locator: 'http://www.example.com',
        version: '0.0.1',
        javascripts: [],
        stylesheets: []
      )

      manager = FrontendComponentsManager.new(creator: creator)
      manager.add(
        OpenStruct.new(
          name: 'test1',
          resource_locator: 'http://www.example.com',
          version: '0.0.1',
          javascripts: [],
          stylesheets: []
        )
      )
    end

    it 'adds a frontend component to list' do
      component = FrontendComponent.new(
        name: 'test1',
        resource_locator: 'http://www.example.com',
        version: '0.0.1',
        javascripts: [],
        stylesheets: []
      )

      manager = FrontendComponentsManager.new(creator: FrontendComponent)
      manager.add(component)
    end

    it 'supports array of hashes' do
      data = [
        {
          name: 'test1',
          resource_locator: 'http://www.example.com',
          version: '0.0.1',
          javascripts: [],
          stylesheets: []
        },
        {
          name: 'test2',
          resource_locator: 'http://www.example.com',
          version: '0.0.1',
          javascripts: [],
          stylesheets: []
        }
      ]

      expect(creator).to receive(:parse).with(data)

      manager = FrontendComponentsManager.new(creator: creator)
      manager.add(data)
    end

    it 'outputs warning on unknown type' do
      manager = FrontendComponentsManager.new(creator: creator)

      result = capture :stderr do
        manager.add('garbage')
      end

      expect(result).to include 'Sorry, but only FrontendComponent, Hash or an Array of Hashes are supported.'
    end
  end

  context '#available_frontend_components' do
    it 'returns available fronted components' do
      component = {
        name: 'test1',
        resource_locator: 'http://www.example.com',
        version: '0.0.1',
        javascripts: [],
        stylesheets: []
      }

      manager = FrontendComponentsManager.new
      manager.add(component)

      expect(manager.available_frontend_components.first.name).to eq 'test1'
    end
  end

  context '#to_s' do
    it 'returns a string representation of self' do
      component = {
        name: 'test1',
        resource_locator: 'http://www.example.com',
        version: '0.0.1',
        javascripts: [],
        stylesheets: []
      }

      manager = FrontendComponentsManager.new
      manager.add(component)

      expect(manager.to_s).to eq <<-EOS.strip_heredoc.chomp
        +-------+------------------------+---------+-------------+-------------+
        | Name  | Resource locator       | Version | Javascripts | Stylesheets |
        +-------+------------------------+---------+-------------+-------------+
        | test1 | http://www.example.com | 0.0.1   |             |             |
        +-------+------------------------+---------+-------------+-------------+
        1 row in set
      EOS
    end
  end

end
