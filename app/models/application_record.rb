class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def to_sym
    self.class.to_s.downcase.to_sym
  end

  def self.human_enum(enum_value)
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_value}")
  end
end
