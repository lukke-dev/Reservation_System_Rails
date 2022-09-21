class User < ApplicationRecord
  validates_presence_of :name
  has_many :reservations

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
