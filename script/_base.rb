# encoding: utf-8
require 'logger'

def logger
  @logger ||= Logger.new($stderr)
end

def require_gem(require_files, gem_name)
  tries = 3

  begin
    require_files.each do |f|
      require f
    end
  rescue
    tries -= 1

    if tries > 0

      logger.info "Installing \"#{gem_name}\" gem."
      system("gem install #{gem_name}")

      retry
    else
      logger.fatal "You need to install \"#{gem_name}\". I tried it #{tries} times, but was not successful."
      exit 1
    end
  end
end
