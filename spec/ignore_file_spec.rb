# encoding: utf-8
require 'spec_helper'

RSpec.describe IgnoreFile do
  context '#initialize' do
    it 'succeeds if path is given' do
      expect {
        IgnoreFile.new create_file 'ignore_file'
      }.not_to raise_error
    end

    it 'fails if path is missing' do
      expect {
        IgnoreFile.new
      }.to raise_error ArgumentError
    end

    context '#ignore?' do
      it 'checks if slide can be ignored' do
        slide1 = Slide.new(name: 01)
        slide1.path = '01.html.erb'

        slide2 = Slide.new(name: 02)
        slide2.path = '02.html.erb'

        path = create_file 'ignore_file', <<-EOS.strip_heredoc
        01
        EOS

        file = IgnoreFile.new(path)

        expect(file).to be_ignore slide1
        expect(file).not_to be_ignore slide2
      end

      it 'strips off full line comments' do
        slide1 = Slide.new(name: 01)
        slide1.path = '# hello world'

        slide2 = Slide.new(name: 02)
        slide2.path = '02.html.erb'

        path = create_file 'ignore_file', <<-EOS.strip_heredoc
        # hello world
        01
        EOS

        file = IgnoreFile.new(path)

        expect(file).not_to be_ignore slide1
        expect(file).not_to be_ignore slide2
      end

      it 'strips off line comments' do
        slide1 = Slide.new(name: 01)
        slide1.path = '01.html.erb'

        slide2 = Slide.new(name: 02)
        slide2.path = '02.html.erb'

        path = create_file 'ignore_file', <<-EOS.strip_heredoc
        01 # hello world
        EOS

        file = IgnoreFile.new(path)

        expect(file).to be_ignore slide1
        expect(file).not_to be_ignore slide2
      end

      it 'handles non existing ignore file' do
        slide1 = Slide.new name: '01.html.erb'
        slide1.path = '01.html.erb'

        file = IgnoreFile.new SecureRandom.hex

        expect(file).not_to be_ignore slide1
      end
    end
  end
end
