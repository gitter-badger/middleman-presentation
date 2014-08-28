# encoding: utf-8
require 'spec_helper'

RSpec.describe PresentationHelper do
  let(:helpers_module) do
    Module.new do
      def helper1
        'helper1'
      end
    end
  end

  context '#initialize' do
    it 'accepts a module' do
      stub_const('HelpersModule', helpers_module)
      expect { PresentationHelper.new HelpersModule }.not_to raise_error
    end

    it 'accepts a block' do
      expect { PresentationHelper.new(proc { def helper1; end }) }.not_to raise_error
    end

    it 'fails on other types' do
      expect { PresentationHelper.new('') }.to raise_error TypeError
    end
  end

  context '.parse' do
    it 'creates helper from array of modules' do
      helpers_module1 = Module.new do
        def helper1
          'helper1'
        end
      end

      helpers_module2 = Module.new do
        def helper2
          'helper2'
        end
      end

      stub_const('HelpersModule1', helpers_module1)
      stub_const('HelpersModule2', helpers_module2)

      helpers = PresentationHelper.parse [HelpersModule1, HelpersModule2]

      expect(helpers.size).to eq 2
      expect(helpers.first.available_methods).to eq [:helper1]
      expect(helpers.last.available_methods).to eq [:helper2]
    end

    it 'creates helper from array of procs' do
      proc1 = proc { def helper1; end }
      proc2 = proc do
        def helper2; end
      end

      helpers = PresentationHelper.parse [proc1, proc2]

      expect(helpers.size).to eq 2
      expect(helpers.first.available_methods).to eq [:helper1]
      expect(helpers.last.available_methods).to eq [:helper2]
    end

    it 'supports mixed arrays' do
      stub_const('HelpersModule', helpers_module)
      proc2 = proc { def helper2; end }

      helpers = PresentationHelper.parse [HelpersModule, proc2]

      expect(helpers.size).to eq 2
      expect(helpers.first.available_methods).to eq [:helper1]
      expect(helpers.last.available_methods).to eq [:helper2]
    end
  end

  context '#to_module' do
    it 'returns self as module' do
      stub_const('HelpersModule', helpers_module)
      helper = PresentationHelper.new HelpersModule

      expect(helper.to_module).to be_kind_of Module
    end

    it 'transforms if block was given' do
      helper = PresentationHelper.new(proc { def helper1; end })

      expect(helper.to_module).to be_kind_of Module
    end
  end

  context '#name' do
    it 'returns name' do
      stub_const('HelpersModule', helpers_module)
      helper = PresentationHelper.new HelpersModule

      expect(helper.name).to eq 'HelpersModule'
    end

    it 'returns anonymous if unkown' do
      helper = PresentationHelper.new proc { def helper1; end }

      expect(helper.name).to eq '<Anonymous>'
    end
  end

  context '#type' do
    it 'returns module if module was given' do
      stub_const('HelpersModule', helpers_module)
      helper = PresentationHelper.new HelpersModule

      expect(helper.type).to eq :MODULE
    end

    it 'returns proc if proc was given' do
      helper = PresentationHelper.new proc { def helper1; end }

      expect(helper.type).to eq :PROC
    end
  end

  context '#available_methods' do
    it 'extracts methods if module was given' do
      stub_const('HelpersModule', helpers_module)
      helper = PresentationHelper.new HelpersModule

      expect(helper.available_methods).to eq [:helper1]
    end

    it 'extracts methods if proc was given' do
      helper = PresentationHelper.new proc { def helper1; end }

      expect(helper.available_methods).to eq [:helper1]
    end

  end
end
