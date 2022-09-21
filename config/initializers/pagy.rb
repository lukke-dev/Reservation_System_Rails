require 'pagy/extras/bootstrap'
require 'pagy/extras/i18n'
Pagy::I18n.load({ locale: 'en' }, { locale: 'pt-BR'})
Pagy::DEFAULT[:items] = 8
Pagy::DEFAULT.freeze