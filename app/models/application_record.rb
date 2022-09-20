class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def to_sym
    self.class.to_s.downcase.to_sym
  end
end
