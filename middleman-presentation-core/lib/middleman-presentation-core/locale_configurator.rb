# encoding: utf-8
module Middleman
  module Presentation
    # Configuration for language on cli
    class LocaleConfigurator
      private

      attr_reader :pattern, :detector, :detected_locale, :logger

      public

      def initialize(
        path:,
        default_locale: nil,
        enforce_available_locales: true,
        detector: FeduxOrgStdlib::ShellLanguageDetector.new,
        logger: FeduxOrgStdlib::Logging::Logger.new
      )
        @pattern         = File.join(path, '*.yml')
        @detector        = detector
        @detected_locale = detect_locale(overwrite: default_locale)
        @logger          = logger

        I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
        I18n.load_path = locale_files
        I18n.backend.load_translations

        I18n.default_locale            = @detected_locale
        I18n.available_locales         = available_locales
        I18n.enforce_available_locales = enforce_available_locales
      end

      def use_locale(l)
        l = l.to_sym

        if l.blank?
          logger.warn I18n.t('errors.use_empty_locale', codes: available_locales.to_list, fallback_locale: detected_locale)
          return
        end

        unless valid_locale?(l)
          logger.warn I18n.t('errors.use_invalid_locale', codes: available_locales.to_list, fallback_locale: detected_locale)
          return
        end

        I18n.locale = l
      end

      def available_locales
        locale_files.map { |f| File.basename(f, '.yml').to_sym }
      end

      def t(*args, &block)
        I18n.t(*args, &block)
      end

      def validate_and_return_locale(l)
        return l.to_sym if valid_locale? l

        logger.warn I18n.t('errors.use_invalid_locale', codes: available_locales.to_list, fallback_locale: detected_locale)

        detected_locale
      end

      private

      def valid_locale?(l)
        available_locales.include? l.to_sym
      end

      def detect_locale(overwrite:)
        options = {}
        options[:allowed] = available_locales
        options[:overwrite] = overwrite.to_sym if overwrite

        detector.detect(**options).language_code
      end

      def locale_files
        @locale_files ||= Dir.glob(pattern)
      end
    end
  end
end
