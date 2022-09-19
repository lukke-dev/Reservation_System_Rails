module SetLocale
  extend ActiveSupport::Concern

  included do
    before_action :set_locale
  end

  def set_locale
    if cookies[:locale].present? && cookies[:locale] != I18n.locale
      I18n.locale = cookies[:locale]
    end
  end
end