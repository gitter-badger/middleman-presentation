# encoding: utf-8
module Middleman
  module Presentation
    class LocaleConfigurator
      private

      attr_reader :pattern, :detector

      public

      def initialize(
        path:,
        enforce_available_locales: true,
        detector: FeduxOrgStdlib::ShellLanguageDetector.new
      )
        @pattern  = File.join(path, '*.yml')
        @detector = detector

        I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
        I18n.load_path = locale_files
        I18n.backend.load_translations

        I18n.default_locale            = detected_locale,
        I18n.available_locales         = available_locales
        I18n.enforce_available_locales = enforce_available_locales
      end

      def use_locale(l)
        l = l.to_sym

        if l.blank?
          Middleman::Presentation.logger.warn I18n.t('errors.use_empty_locale', codes: available_locales.to_list, fallback_locale: detected_locale)
          return
        end

        unless valid_locale?(l)
          Middleman::Presentation.logger.warn I18n.t('errors.use_invalid_locale', codes: available_locales.to_list, fallback_locale: detected_locale)
          return
        end

        I18n.default_locale = l
      end

      def available_locales
        locale_files.map { |f| File.basename(f, '.yml').to_sym }
      end

      private

      def valid_locale?(l)
        available_locales.include? l
      end

      def detected_locale
        detector.detect(allowed: available_locales).language_code
      end

      def locale_files
        @locale_files ||= Dir.glob(pattern)
      end
    end
  end
end
