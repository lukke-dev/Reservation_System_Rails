class Reservation < ApplicationRecord
  validates_presence_of :user_id, :book_id, :booking_date, :return_date
  belongs_to :user
  belongs_to :book

  enum booking_status:  %i[ open finished ]
end
