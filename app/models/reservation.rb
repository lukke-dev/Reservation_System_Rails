class Reservation < ApplicationRecord
  validates_presence_of :booking_date, :return_date
  validate :validate_dates
  belongs_to :user
  belongs_to :book

  enum booking_status:  %i[ open finished ]

  ransacker :booking_date do
    Arel.sql('date(booking_date)')
  end

  ransacker :return_date do
    Arel.sql('date(return_date)')
  end

  def validate_dates
    if self.booking_date.present? && self.return_date.present?
      self.errors.add(:booking_date, 'A data de de reserva não pode ser maior que a data de devoluçao') if self.booking_date > self.return_date
    end
  end
end
