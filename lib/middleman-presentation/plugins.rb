# encoding: utf-8
module Middleman
  module Presentation
  class PluginManager
    @plugin_prefix = /^middleman-presentation-/

    class << self
      attr_reader :plugin_prefix
    end

    # Placeholder when no associated gem found, displays warning
    class NoPlugin
      private

      attr_reader :name

      public

      def initialize(name)
        @name = name
      end

      def method_missing(*args)
        warn "Warning: The plugin '#{name}' was not found! (no gem found)"
      end
    end

    class Plugin
      attr_accessor :name, :gem_name, :enabled, :spec, :active

      def initialize(name, gem_name, spec, enabled)
        @name, @gem_name, @enabled, @spec = name, gem_name, enabled, spec
      end

      # Disable a plugin. (prevents plugin from being loaded, cannot
      # disable an already activated plugin)
      def disable!
        self.enabled = false
      end

      # Enable a plugin. (does not load it immediately but puts on
      # 'white list' to be loaded)
      def enable!
        self.enabled = true
      end

      # Activate the plugin (require the gem - enables/loads the
      # plugin immediately at point of call, even if plugin is
      # disabled)
      # Does not reload plugin if it's already active.
      def activate!
        begin 
          if !active?
            begin
              require gem_name
            rescue LoadError
              require gem_name.gsub(/-/, '/')
            end
          end
        rescue LoadError => e
          warn "Found plugin #{gem_name}, but could not require '#{gem_name}' or '#{gem_name.gsub(/-/, '/')}'"
          warn e
        rescue => e
          warn "require '#{gem_name}' # Failed, saying: #{e}"
        end

        self.active = true
        self.enabled = true
      end

      alias active? active
      alias enabled? enabled
    end

    private

    attr_reader :plugins

    public

    def initialize(plugins: [])
      @plugins = plugins
    end

    # Find all installed plugins and store them in an internal array.
    def locate_plugins
      Gem.refresh

      gem_handler.each do |gem|
        next if gem.name !~ self.class.plugin_prefix 

        plugin_name = gem.name.sub(self.class.plugin_prefix, '')
        plugin = Plugin.new(plugin_name, gem.name, gem, true) if !gem_located?(gem.name)

        if Middleman::Presentation.config.plugin_mode == :permissive
          plugin.disable! if Middleman::Presentation.config.include? gem.name
        elsif Middleman::Presentation.config.plugin_mode == :strict
          plugin.disable! if !Middleman::Presentation.config.include?(gem.name)
        else
          fail PluginModeInvalidError, JSON.dump(mode: Middleman::Presentation.config.plugin_mode)
        end

        @plugins << plugin
      end

      @plugins
    end

    private

    def gem_handler
      Gem::Specification.respond_to?(:each) ? Gem::Specification : Gem.source_index.find_name('')
    end

    public

    # @return [Hash] A hash with all plugin names (minus the '<prefix>-') as
    #   keys and Plugin objects as values.
    def plugins
      h = Hash.new { |_, key| NoPlugin.new(key) }

      @plugins.each do |plugin|
        h[plugin.name] = plugin
      end

      h
    end

    # Require all enabled plugins, disabled plugins are skipped.
    def load_plugins
      @plugins.each do |plugin|
        plugin.activate! if plugin.enabled?
      end
    end

    private

    def gem_located?(gem_name)
      @plugins.any? { |plugin| plugin.gem_name == gem_name }
    end
  end
end
end
