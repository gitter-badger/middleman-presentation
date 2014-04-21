# encoding: utf-8
require 'logger'

module Presentation
  module Helper
    def logger
      @logger ||= Logger.new($stderr)
    end

    def install_gem(gem_name)
      logger.info "Installing \"#{gem_name}\" gem."
      system("gem install #{gem_name}")
    end

    def run_task(task)
      system("bundle exect thor #{task}")
    end

    def require_gem(gem_name, require_files)
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

  end
end
