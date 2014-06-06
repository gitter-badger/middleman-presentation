# encoding: utf-8
require 'spec_helper'

describe Middleman::Presentation::Helpers do
  context '#image_gallery' do
    let(:helper) do
      Class.new do 
        include Middleman::Presentation::Helpers
      end.new
    end

    it 'generates an image gallery based on array of images' do
      result = helper.image_gallery %w{img1 img2}, image_gallery_id: 'gallery_id'

      expected_result = <<-EOS.strip_heredoc.chomp
        <a href="img1" data-lightbox="gallery_id">
          <img src="img1" class="fd-preview-image">
        </a>
        <a href="img2" data-lightbox="gallery_id">
          <img src="img2" class="fd-preview-image">
        </a>
      EOS

      expect(result).to eq expected_result
    end

    it 'generates an image gallery based on hash of images' do
      result = helper.image_gallery({'img1' => 'title1', 'img2' => 'title2'}, image_gallery_id: 'gallery_id')

      expected_result = <<-EOS.strip_heredoc.chomp
        <a href="img1" data-lightbox="gallery_id">
          <img src="img1" alt="title1" class="fd-preview-image">
        </a>
        <a href="img2" data-lightbox="gallery_id">
          <img src="img2" alt="title2" class="fd-preview-image">
        </a>
      EOS

      expect(result).to eq expected_result
    end
  end
end
