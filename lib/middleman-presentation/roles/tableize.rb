# encoding: utf-8
module Middleman
  module Presentation
    module Tablelize

      def table(data)
        length = data.keys.inject(0) { |a, e| e.length > a ? e.length : a }

        result = []
        result << sprintf("%#{length}s | %s", 'option', 'value')
        result << sprintf("%s + %s", '-' * length, '-' * 80)

        data.each do |field, value|
          value = if value == false
                    Array(value)
                  elsif value.blank?
                    Array('is undefined')
                  elsif value.is_a?(Hash) || value.is_a?(Array)
                    value
                  else
                    Array(value)
                  end

          result << sprintf("%#{length}s | %s", field, value.to_list)
        end

        result.join("\n")
      end

      module_function :table
    end
  end
end
