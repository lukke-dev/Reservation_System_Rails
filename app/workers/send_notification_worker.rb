require 'sidekiq/api'

class SendNotificationWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'send_notification_worker'

  def perform(book_id)
    SendNotificationService.new(book_id).perform
	end
end