# Restore original behaviour of thor
# rubocop:disable Style/ClassAndModuleChildren
class ::Thor
  # rubocop:enable Style/ClassAndModuleChildren
  module Actions
    # Create file helper class
    class CreateFile
      def on_conflict_behavior(&block)
        if identical?
          say_status :identical, :blue
        else
          options = base.options.merge(config)
          force_or_skip_or_conflict(options[:force], options[:skip], &block)
        end
      end
    end
  end
end
