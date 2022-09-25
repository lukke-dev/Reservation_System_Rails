require 'csv'

class Book < ApplicationRecord
  validates_presence_of :title, :author
  validates :title, uniqueness: true
  belongs_to :category
  has_many :reservations, dependent: :destroy
  after_create :send_notification
  extend ExportCsv

  EXPORT_CSV = %w[id title author category_id].freeze
  CHANGE_ATTRS = { user_id: 'user.name', category_id: 'category_name' }.freeze

  IMPORT_CSV = [
    I18n.t('activerecord.attributes.book.title'),
    I18n.t('activerecord.attributes.book.author'),
    "Id #{I18n.t('activerecord.attributes.book.category_id')}"
  ].freeze

  def category_name
    category.name
  end

  def self.save_file_on_server(file, user_id)
    folder = File.join(Rails.root.join('tmp', 'imports'))
    FileUtils.mkdir_p(folder) unless Dir.exist?(folder)

    filename = "#{SecureRandom.alphanumeric(10)}-import-books.csv"
    path = File.join(folder, filename)

    File.open(path, 'wb') { |f| f.write(CSV.parse(file)) }
    ImportCsvWorker.perform_async(filename, user_id)
  end

  def send_notification
    SendNotificationWorker.perform_async(self.id)
  end

  ransacker :created_at do
    Arel.sql('date(created_at)')
  end

  ransacker :updated_at do
    Arel.sql('date(updated_at)')
  end
end
