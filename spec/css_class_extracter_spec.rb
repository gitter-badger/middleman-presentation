# encoding: utf-8
RSpec.describe CssClassExtracter do
  context '#extract' do
    it 'extract classes' do
      file = create_file 'index.html', <<-EOS.strip_heredoc
    <html class="hello">
    </html>
      EOS

      klasses = CssClassExtracter.new.extract([file])
      expect(klasses).to include 'hello'
    end

    it 'ignores classes' do
      file = create_file 'index.html', <<-EOS.strip_heredoc
    <html class="hello test">
    </html>
      EOS

      klasses = CssClassExtracter.new.extract([file], ignore: ['test'])
      expect(klasses).to include 'hello'
      expect(klasses).not_to include 'test'
    end
  end
end
