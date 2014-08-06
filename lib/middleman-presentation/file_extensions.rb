# encoding: utf-8
require 'rbconfig'
require 'win32/file' if File::ALT_SEPARATOR

class File
  if File::ALT_SEPARATOR
    MSWINDOWS = true
    if ENV['PATHEXT']
      WIN32EXTS = ('.{' + ENV['PATHEXT'].tr(';', ',').tr('.','') + '}').downcase
    else
      WIN32EXTS = '.{exe,com,bat}'
    end
  else
    MSWINDOWS = false
  end

  class << self
    def which(program, path=ENV['PATH'])
      if path.nil? || path.empty?
        raise ArgumentError, "path cannot be empty"
      end

      # Bail out early if an absolute path is provided.
      if program =~ /^\/|^[a-z]:[\\\/]/i
        program += WIN32EXTS if MSWINDOWS && File.extname(program).empty?
        found = Dir[program].first
        if found && File.executable?(found) && !File.directory?(found)
          return found
        else
          return nil
        end
      end

      # Iterate over each path glob the dir + program.
      path.split(File::PATH_SEPARATOR).each{ |dir|
        dir = File.expand_path(dir)

        next unless File.exist?(dir) # In case of bogus second argument
        file = File.join(dir, program)

        # Dir[] doesn't handle backslashes properly, so convert them. Also, if
        # the program name doesn't have an extension, try them all.
        if MSWINDOWS
          file = file.tr("\\", "/")
          file += WIN32EXTS if File.extname(program).empty?
        end

        found = Dir[file].first

        # Convert all forward slashes to backslashes if supported
        if found && File.executable?(found) && !File.directory?(found)
          found.tr!(File::SEPARATOR, File::ALT_SEPARATOR) if File::ALT_SEPARATOR
          return found
        end
      }

      nil
    end
  end
end
