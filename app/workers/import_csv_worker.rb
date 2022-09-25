require 'sidekiq/api'

class ImportCsvWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'import_csv_worker'

  def perform(filename, user_id)
    ImportCsvService.new(filename, user_id).perform
	end
end