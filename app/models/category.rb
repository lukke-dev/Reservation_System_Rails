class Category < ApplicationRecord
	validates_presence_of :name
	has_many :books, dependent: :destroy
	extend ExportCsv

  ATTRIBUTES_EXPORT_CSV = %w[id name]
end
