class Category < ApplicationRecord
	validates_presence_of :name
	has_many :books, dependent: :destroy
end
