class User < ApplicationRecord
  validates_presence_of :name
  has_many :reservations
  has_many :notifications

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
