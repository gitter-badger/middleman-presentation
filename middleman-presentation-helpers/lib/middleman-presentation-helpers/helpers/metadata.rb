# encoding: utf-8
module Middleman
  module Presentation
    module Helpers
      # Meta daa helper
      module Metadata
        # Generate metadata with html markup
        #
        # @param [Array, String] requested_fields
        #   The fields for which the markup should be generated
        #
        # @param [Array, String] allowed_fields
        #   The fields which are allowed, normally this is something like
        #   Middleman::Presentation.config.known_options
        #
        # @return [String]
        #   The generated metadata
        def metadata_markup(requested_fields, allowed_fields)
          requested_fields = Array(requested_fields).map(&:to_sym)
          allowed_fields   = Array(allowed_fields).map(&:to_sym)
          unknown_fields   = requested_fields - allowed_fields

          fail ArgumentError, Middleman::Presentation.t('errors.unknown_metadata_fields', fields: unknown_fields.to_list, count: unknown_fields.size) unless unknown_fields.blank?

          Erubis::Eruby.new(template).result(fields: requested_fields).chomp
        end

        private

        def template
          <<-EOS.strip_heredoc
          <%- fields.each do |f| -%>
          <span class="mp-meta-<%= f %>"><%= Middleman::Presentation.config.public_send f %></span>
          <%- end -%>
          EOS
        end
      end
    end
  end
end
