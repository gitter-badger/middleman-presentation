# encoding: utf-8
# A sample Guardfile
# More info at https://github.com/guard/guard#readme

# Add files and commands to this file, like the example:
#   watch(%r{file/path}) { `command(s)` }
#
guard :shell do
  watch(%r{^source/slides/.+\.(?:erb|html)}) do
    $stderr.puts 'Running middleman'
    system('bundle exec middleman build')
  end
end
