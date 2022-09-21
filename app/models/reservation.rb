class Reservation < ApplicationRecord
  validates_presence_of :booking_date, :return_date
  validate :validate_dates
  belongs_to :user
  belongs_to :book
  extend ExportCsv

  EXPORT_CSV = %w[id user_id book_id booking_date return_date].freeze
  CHANGE_ATTRS = {			
    user_id: 'user_name',
    book_id: 'book_title',
    booking_date: 'booking_date_formated',
    return_date: 'return_date_formated'
  }.freeze

  enum booking_status: { opened: 0, finished: 1 }

  ransacker :booking_date do
    Arel.sql('date(booking_date)')
  end

  ransacker :return_date do
    Arel.sql('date(return_date)')
  end

  def user_name
    user.name
  end

  def book_title
    book.title
  end
  
  def self.human_booking_statuses
    booking_statuses.map{ |k, v| [human_enum(k), v] }
  end

  def booking_date_formated
    I18n.l(booking_date.to_date)
  end

  def return_date_formated
    I18n.l(return_date.to_date)
  end

  def validate_dates
    if self.booking_date.present? && self.return_date.present?
      self.errors.add(:booking_date, I18n.t('errors.invalide_date')) if self.booking_date > self.return_date
    end
  end
end
