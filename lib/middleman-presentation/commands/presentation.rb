# encoding: utf-8
module Middleman
  module Cli
    # This class provides an 'presentation' command for the middleman CLI.
    class Presentation < Thor
      include Thor::Actions

      check_unknown_options!

      namespace :presentation

      def self.source_root
        ENV['MM_ROOT']
      end

      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
      end

      option :speaker, required: true, desc: 'Name of speaker'
      option :title, required: true, desc: 'Title of presentation'
      option :bower_directory, default: 'vendor/assets/components', desc: 'Directory for bower components in "source"-directory'
      option :date, desc: 'Date of presentation'
      option :author, desc: 'Author of presentation'
      option :description, desc: 'Description for presentation'
      option :subtitle, desc: 'Subtitle of presentation'
      option :homepage, desc: 'Homepage of company and/or speaker'
      option :company, desc: 'Company or employer or organization of speaker'
      option :license, desc: 'License of the presentation, e.g. CC BY'
      option :location, desc: 'Location where the presentation take place'
      option :audience, desc: 'Audience of presentation'

      option :use_open_sans, type: :boolean, default: true, desc: 'Include open-sans'
      option :use_jquery, type: :boolean, default: true, desc: 'Include jquery'
      option :use_lightbox, type: :boolean, default: true, desc: 'Include lightbox 2'

      option :activate_controls, type: :boolean, default: true, desc: 'Activate controls in reveal.js'
      option :activate_progress, type: :boolean, default: true, desc: 'Activate progress in reveal.js'
      option :activate_history, type: :boolean, default: true, desc: 'Activate history in reveal.js'
      option :activate_center, type: :boolean, default: true, desc: 'Activate center in reveal.js'

      option :install_assets, type: :boolean, default: true, desc: 'Install assets'

      desc 'presentation ', 'Initialize a new presentation'
      def presentation(name)
        source_paths << File.expand_path('../../../../templates', __FILE__)

        shared_instance = ::Middleman::Application.server.inst

        # This only exists when the config.rb sets it!
        if shared_instance.extensions.key? :presentation
          presentation_inst = shared_instance.extensions[:presentation]

          @bower_directory = options[:bower_directory]

          @author          = options[:author]
          @speaker         = options[:speaker]
          @title           = options[:title]
          @description     = options[:description]
          @subtitle        = options[:subtitle]
          @date            = options[:date]
          @homepage        = options[:homepage]
          @company         = options[:company]
          @license         = options[:license]
          @location        = options[:location]
          @audience        = options[:audience]

          @external_assets = {}
          @external_assets["reveal.js"] = "latest"
          @external_assets["jquery"] = "~1.11.0"   if options[:use_jquery] == true
          @external_assets["open-sans"] = "latest" if options[:use_open_sans] == true
          @external_assets["lightbox2"] = "https://github.com/lokesh/lightbox2/" if options[:use_lightbox] == true

          @revealjs_config = {}
          @revealjs_config[:controls] = options[:activate_controls]
          @revealjs_config[:progress] = options[:activate_progress]
          @revealjs_config[:history]  = options[:activate_history]
          @revealjs_config[:center]   = options[:activate_center]

          slides_directory = File.join shared_instance.source_dir, presentation_inst.options.slides_directory
          data_directory = File.join shared_instance.root, 'data'

          #empty_directory slides_directory
          #empty_directory data_directory

          template 'data/metadata.yml.tt', File.join(data_directory, 'metadata.yml')
          template 'data/config.yml.tt', File.join(data_directory, 'config.yml')
          template '.bowerrc.tt', File.join(shared_instance.root, '.bowerrc')
          template 'bower.json.tt', File.join(shared_instance.root, 'bower.json')

          copy_file 'layout.erb', File.join(shared_instance.source_dir, 'layout.erb')
          copy_file 'slides/00.html.erb', File.join(slides_directory, '00.html.erb')
          copy_file 'LICENSE.presentation', File.join(shared_instance.root, 'LICENSE.presentation')

          run 'bower install' if options[:install_assets] == true
        else
          raise Thor::Error.new 'You need to activate the presentation extension in config.rb before you can create a slide.'
        end
      end
    end
  end
end
