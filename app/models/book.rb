class Book < ApplicationRecord
  belongs_to :category
  has_many :reservations, dependent: :destroy

  ransacker :created_at do
    Arel.sql('date(created_at)')
  end

  ransacker :updated_at do
    Arel.sql('date(updated_at)')
  end
end
