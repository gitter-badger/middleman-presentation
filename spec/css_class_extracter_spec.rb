# encoding: utf-8
require 'spec_helper'

RSpec.describe CssClassExtracter do
  context '#extract' do
    it 'extract classes' do
      file = create_file 'index.html', <<-EOS.strip_heredoc
    <html class="hello">
    </html>
      EOS

      klasses = CssClassExtracter.new.extract([file])
      expect(klasses.size).to eq 1
      expect(klasses.first.name).to eq 'hello'
    end

    it 'ignores classes' do
      file = create_file 'index.html', <<-EOS.strip_heredoc
    <html class="hello test">
    </html>
      EOS

      klasses = CssClassExtracter.new.extract([file], ignore: ['test'])
      expect(klasses.size).to eq 1
      expect(klasses.first.name).to eq 'hello'
    end
  end
end
