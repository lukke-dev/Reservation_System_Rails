class Category < ApplicationRecord
	validates :name, uniqueness: true
	has_many :books, dependent: :destroy
	extend ExportCsv

  EXPORT_CSV = %w[id name].freeze
	CHANGE_ATTRS = {}.freeze
end
