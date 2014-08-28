# encoding: utf-8
require 'spec_helper'

RSpec.describe IgnoreFile do
  context '#initialize' do
    it 'succeeds if path is given' do
      expect do
        file = touch_file('ignore_file')
        IgnoreFile.new absolute_path(file)
      end.not_to raise_error
    end

    it 'fails if path is missing' do
      expect do
        IgnoreFile.new
      end.to raise_error ArgumentError
    end

    context '#ignore?' do
      it 'checks if slide can be ignored' do
        slide1 = instance_double('Middleman::Presentation::ExistingSlide')
        allow(slide1).to receive(:match?).and_return(false)
        allow(slide1).to receive(:match?).with(/(?-mix:^!$)|(?-mix:01)/).and_return(true)

        slide2 = instance_double('Middleman::Presentation::ExistingSlide')
        allow(slide2).to receive(:match?).and_return(false)

        file = write_file 'ignore_file', <<-EOS.strip_heredoc
        01
        EOS

        ignore_file = IgnoreFile.new(absolute_path(file))

        expect(ignore_file).to be_ignore slide1
        expect(ignore_file).not_to be_ignore slide2
      end

      it 'strips off full line comments' do
        slide1 = instance_double('Middleman::Presentation::ExistingSlide')
        allow(slide1).to receive(:match?).with(/(?-mix:^!$)|(?-mix:02)/).and_return(false)

        path = write_file 'ignore_file', <<-EOS.strip_heredoc
        # 01
        02
        EOS

        file = IgnoreFile.new(path)

        expect(file).not_to be_ignore slide1
      end

      it 'strips off line comments' do
        slide1 = instance_double('Middleman::Presentation::ExistingSlide')
        allow(slide1).to receive(:match?).and_return(false)
        allow(slide1).to receive(:match?).with(/(?-mix:^!$)|(?-mix:01)/).and_return(true)

        file = write_file 'ignore_file', <<-EOS.strip_heredoc
        01 # hello world
        EOS

        ignore_file = IgnoreFile.new(absolute_path(file))

        expect(ignore_file).to be_ignore slide1
      end

      it 'handles non existing ignore file' do
        slide1 = instance_double('Middleman::Presentation::ExistingSlide')

        file = IgnoreFile.new SecureRandom.hex

        expect(file).not_to be_ignore slide1
      end
    end
  end
end
