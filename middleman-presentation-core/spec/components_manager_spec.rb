# encoding: utf-8
require 'spec_helper'

RSpec.describe ComponentsManager do
  let(:component) { instance_double('Middleman::Presentation::Component') }

  before(:each) do
    allow(component).to receive(:root_directory=)
  end

  context '#add' do
    it 'passes the bower directory to component' do
      expect(component).to receive(:root_directory=).with('dir')

      manager = ComponentsManager.new
      manager.bower_directory = 'dir'
      manager.add(component)
      manager.available_components
    end

    it 'outputs warning on unknown type' do
      manager = ComponentsManager.new

      result = capture :stderr do
        manager.add('garbage')
      end

      expect(result).to include 'Sorry, but argument "garbage" needs to respond to "#root_directory="'
    end
  end

  context '#available_components' do
    it 'returns available fronted components' do
      allow(component).to receive(:name).and_return('test1')

      manager = ComponentsManager.new
      manager.add(component)

      expect(manager.available_components.first.name).to eq 'test1'
    end

    it 'returns the frontend components in the order they were added' do
      components = []

      5.times do |i|
        component = instance_double('Middleman::Presentation::Component')
        allow(component).to receive(:name).and_return("test#{i - 1}")
        allow(component).to receive(:root_directory=)

        components << component
      end

      manager = ComponentsManager.new
      manager.add(components[0])
      manager.add(components[2])
      manager.add(components[4])
      manager.add(components[1])
      manager.add(components[3])
      manager.add(components[3])
      manager.add(components[4])
      manager.add(components[4])

      expect(manager.available_components[0].name).to be components[0].name
      expect(manager.available_components[1].name).to be components[2].name
      expect(manager.available_components[2].name).to be components[4].name
      expect(manager.available_components[3].name).to be components[1].name
      expect(manager.available_components[4].name).to be components[3].name
    end
  end

  context '#each_fetchable_component' do
    it 'iterates over each fetchable component' do
      expect(component).to receive(:fetchable?).and_return(true)

      manager = ComponentsManager.new
      manager.add(component)

      result = []
      manager.each_fetchable_component { |c| result << c }

      expect(result.count).to eq 1
    end
  end

  context '#each_nonfetchable_component' do
    it 'iterates over each non fetchable component' do
      expect(component).to receive(:fetchable?).and_return(false)

      manager = ComponentsManager.new
      manager.add(component)

      result = []
      manager.each_nonfetchable_component { |c| result << c }

      expect(result.count).to eq 1
    end
  end

  context '#root_directory=' do
    it 'marks the cache as dirty' do
      cache = instance_double('Middleman::Presentation::Cache')
      expect(cache).to receive(:mark_dirty)

      manager = ComponentsManager.new(cache: cache)
      manager.bower_directory = 'asdf'
    end
  end

  context '#to_s' do
    it 'returns a string representation of self' do
      allow(component).to receive(:name).and_return('test.d/test1')
      allow(component).to receive(:resource_locator).and_return('http://www.example.com')
      allow(component).to receive(:version).and_return('0.0.1')
      allow(component).to receive(:base_path).and_return('test.d')
      allow(component).to receive(:path).and_return('test.d/test1')
      allow(component).to receive(:importable_files).and_return([])
      allow(component).to receive(:loadable_files).and_return([])
      allow(component).to receive(:ignorable_files).and_return([])
      allow(component).to receive(:output_paths).and_return([])

      manager = ComponentsManager.new
      manager.add(component)

      expect(manager.to_s).to eq <<-EOS.strip_heredoc.chomp
        ************************ 1. row ************************
                    Name: test.d/test1
                    Path: test.d/test1
               Base path: test.d
        Resource locator: http://www.example.com
                 Version: 0.0.1
        Importable files: 
          Loadable files: 
         Ignorable files: 
            Output paths: 
        1 row in set
      EOS
    end
  end

end
