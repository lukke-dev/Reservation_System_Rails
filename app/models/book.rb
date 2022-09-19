class Book < ApplicationRecord
  validates_presence_of :title, :author
  validates :title, uniqueness: true
  belongs_to :category
  has_many :reservations, dependent: :destroy
  extend ExportCsv

  ATTRIBUTES_EXPORT_CSV = %w[id title author category_id]

  ransacker :created_at do
    Arel.sql('date(created_at)')
  end

  ransacker :updated_at do
    Arel.sql('date(updated_at)')
  end
end
