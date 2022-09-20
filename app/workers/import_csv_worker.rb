require 'sidekiq/api'

class ImportCsvWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'import_csv_worker'

  def perform(filename)
    ImportCsvService.new(filename).perform
	end
end