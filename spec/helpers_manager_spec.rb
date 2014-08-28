# encoding: utf-8
require 'spec_helper'

RSpec.describe HelpersManager do
  let(:helpers_module) do
    Module.new do
      def helper1
        'helper1'
      end
    end
  end

  context '#add' do
    it 'let you add modules' do
      stub_const('HelpersModule', helpers_module)

      manager = HelpersManager.new
      manager.add HelpersModule
    end

    it 'let you add procs' do
      manager = HelpersManager.new
      manager.add do
        def helper1
          'helper1'
        end
      end
    end
  end

  context '#available_helpers' do
    it 'returns a module' do
      manager = HelpersManager.new
      manager.add do
        def helper1
          'helper1'
        end
      end

      expect(manager.available_helpers).to be_kind_of Module
    end

    it 'the returned module has all methods in there' do
      manager = HelpersManager.new
      manager.add do
        def helper1
          'helper1'
        end
      end

      local_module = Module.new do
        extend manager.available_helpers
      end

      expect(local_module.helper1).to eq 'helper1'
    end
  end

  context '#to_s' do
    it 'returns a string representation of self' do
      stub_const('HelpersModule', helpers_module)

      manager = HelpersManager.new
      manager.add HelpersModule
      manager.add do
        def helper2
          'helper2'
        end

        def helper3
          'helper3'
        end

        def self.helper4
          'helper4'
        end
      end

      expect(manager.to_s).to eq <<-EOS.strip_heredoc.chomp
        +---------------+--------+--------------------------------------+
        | Name          | Type   | Available methods                    |
        +---------------+--------+--------------------------------------+
        | <Anonymous>   | PROC   | "helper2", "helper3", "self.helper4" |
        | HelpersModule | MODULE | "helper1"                            |
        +---------------+--------+--------------------------------------+
        2 rows in set
      EOS
    end
  end
end
