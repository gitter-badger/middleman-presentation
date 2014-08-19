# encoding: utf-8
module Middleman
  module Presentation
    class HelpersManager
      def self.register(*modules, &block)
        if block_given?
          mod = Module.new
          mod.module_eval(&block)
          modules += [mod]
        end

        modules.each { |m| Middleman::Presentation::Helpers.include m }
      end
    end
  end
end
