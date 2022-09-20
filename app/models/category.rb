class Category < ApplicationRecord
	validates_presence_of :name
	has_many :books, dependent: :destroy
	extend ExportCsv

  EXPORT_CSV = %w[id name].freeze
	CHANGE_ATTRS = {}.freeze
end
