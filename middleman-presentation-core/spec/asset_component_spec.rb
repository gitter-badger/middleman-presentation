# encoding: utf-8
require 'spec_helper'

RSpec.describe AssetComponent do
  context '#name' do
    it 'is the same as path' do
      component = AssetComponent.new(path: 'test1')

      expect(component.name).to eq 'test1'
      expect(component.path).to eq 'test1'
    end
  end

end
