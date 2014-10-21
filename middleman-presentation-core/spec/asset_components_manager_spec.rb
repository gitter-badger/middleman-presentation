# encoding: utf-8
require 'spec_helper'

RSpec.describe AssetComponentsManager do
  let(:creator_stub) { Class.new }
  let(:creator) { stub_const('Middleman::Presentation::AssetComponent', creator_stub) }

  context '#add' do
    it 'adds a hash to component list' do
      expect(creator).to receive(:new).with(
        name: 'dir.d/test1',
        path: 'dir.d/test1',
        resource_locator: 'http://www.example.com',
        version: '0.0.1',
        loadable_files: [],
        importable_files: [],
      )

      manager = AssetComponentsManager.new(creator: creator)
      manager.add(
        name: 'dir.d/test1',
        path: 'dir.d/test1',
        resource_locator: 'http://www.example.com',
        version: '0.0.1',
        importable_files: [],
        loadable_files: []
      )
    end

    it 'adds a struct to component list' do
      expect(creator).to receive(:new).with(
        name: 'test1',
        resource_locator: 'http://www.example.com',
        version: '0.0.1',
        importable_files: [],
        loadable_files: [],
        path: 'dir.d/test1'
      )

      manager = AssetComponentsManager.new(creator: creator)
      manager.add(
        OpenStruct.new(
          name: 'test1',
          resource_locator: 'http://www.example.com',
          version: '0.0.1',
          importable_files: [],
          loadable_files: [],
          path: 'dir.d/test1'
        )
      )
    end

    it 'outputs warning on unknown type' do
      manager = AssetComponentsManager.new(creator: creator)

      result = capture :stderr do
        manager.add('garbage')
      end

      expect(result).to include 'Sorry, but argument "garbage" needs to respond to "#to_h"'
    end
  end

  context '#available_components' do
    it 'returns available fronted components' do
      component = {
        path: 'test1',
        resource_locator: 'http://www.example.com',
        version: '0.0.1'
      }

      manager = AssetComponentsManager.new
      manager.add(component)

      expect(manager.available_components.first.path).to eq 'test1'
    end

    it 'returns the frontend components in the order they were added' do
      components = []

      5.times do |i|
        components << {
          path: "test#{i - 1}",
          resource_locator: 'http://www.example.com'
        }
      end

      manager = AssetComponentsManager.new
      manager.add(components[0])
      manager.add(components[2])
      manager.add(components[4])
      manager.add(components[1])
      manager.add(components[3])
      manager.add(components[3])
      manager.add(components[4])
      manager.add(components[4])

      expect(manager.available_components[0].path).to be components[0][:path]
      expect(manager.available_components[1].path).to be components[2][:path]
      expect(manager.available_components[2].path).to be components[4][:path]
      expect(manager.available_components[3].path).to be components[1][:path]
      expect(manager.available_components[4].path).to be components[3][:path]
    end
  end

  context '#to_s' do
    it 'returns a string representation of self' do
      component = {
        path: 'test1',
        resource_locator: 'http://www.example.com',
        version: '0.0.1'
      }

      manager = AssetComponentsManager.new
      manager.add(component)

      expect(manager.to_s).to eq <<-EOS.strip_heredoc.chomp
        +-------+------------------------+---------+------------------+----------------+-----------------+--------------------+
        | Path  | Resource locator       | Version | Importable files | Loadable files | Ignorable files | Output directories |
        +-------+------------------------+---------+------------------+----------------+-----------------+--------------------+
        | test1 | http://www.example.com | 0.0.1   |                  |                |                 |                    |
        +-------+------------------------+---------+------------------+----------------+-----------------+--------------------+
        1 row in set
      EOS
    end
  end

end
