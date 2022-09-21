module SetLocale
  extend ActiveSupport::Concern

  included do
    before_action :set_locale
  end

  def set_locale
    session[:locale] = params[:locale] if params[:locale].present?
    I18n.locale = session[:locale] || I18n.default_locale
  end
end

