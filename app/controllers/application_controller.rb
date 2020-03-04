class ApplicationController < ActionController::Base
	around_action :switch_locale

	def switch_locale
		# If there is a language in URL and it's available in the app
		if I18n.available_locales.include?(params[:locale]&.to_sym)
			# Set locale to the provided one
			I18n.locale = params[:locale]&.to_sym if I18n.locale != params[:locale]&.to_sym

			# Show content
			return yield
		end

		# Select language preferences from browser
		languages = browser.accept_language.map(&:code)

		# Select the first language available, fallback to english
		locale = languages.find { |l| I18n.available_locales.include?(l.to_sym) } || :en

		# Redirect to the target page with locale
		redirect_to url_for(params.permit(:locale).merge(locale: locale, only_path: true))
	end

	# Prevents to require adding the locale to every URL helpers
	def default_url_options
		{ locale: I18n.locale }
	end
end
