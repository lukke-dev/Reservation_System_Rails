class SendNotificationService
  attr_accessor :book

  def initialize(book_id)
    @book = Book.find(book_id)
  end

  def perform
    begin
      execute
    rescue => e
      puts e
    end
  end

	def execute
		return if @book.nil?
		User.select(:id).find_each do |user|
			notification = create_notification(user.id)
			NotificationChannel.broadcast_to(user.id, { notification: notification, action: 'add_notification' })
		end
	end

  def create_notification(user_id)
    Notification.create!(
      body: body_message,
      user_id: user_id
    )
  end

	def body_message
		"#{@book.title} adicionado a coleção!"
	end
end