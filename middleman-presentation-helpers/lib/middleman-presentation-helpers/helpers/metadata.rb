# encoding: utf-8
module Middleman
  module Presentation
    module Helpers
      module Metadata
        def metadata_markup(requested_fields:, allowed_fields:)
          requested_fields = Array(requested_fields)
          allowed_fields   = Array(allowed_fields)
          unknown_fields   = allowed_fields - requested_fields

          fail ArgumentError, Middleman::Presentation.t('errors.unknown_metadata_fields', fields: unknown_fields.to_list) unless unknown_fields.blank?

          Erubis::Eruby.new(template).result(fields: requested_fields)
        end

        private

        def template
          <<-EOS.strip_heredoc
        <%- fields.each do |f| -%>
        <%- next if f.blank? -%>
        <span class="mp-meta-<%= f %>">
          <%= Middleman::Presentation.config.send_public f %>
        </span>
        <%- end -%>
          EOS
        end
      end
    end
  end
end
