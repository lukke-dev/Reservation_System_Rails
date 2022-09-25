class ImportCsvService
  attr_accessor :path, :filename, :content, :user_id

  def initialize(filename, user_id)
    @path = Rails.root.join('tmp', 'imports', filename).to_s
    @filename = filename
    @content = prepare_file
    @user_id = user_id
  end

  def perform
    begin
      return if content.nil?
      prepare_objects
      create_records
      delete_file
      message = 'Importação realizada com sucesso'
    rescue => error
      Airbrake.notify(error)
      message = 'Falha ao importar livros'
    end
    notification = create_notification(message)
    NotificationChannel.broadcast_to(user_id, { notification: notification, action: 'add_notification' })
  end

  def create_notification(message)
    Notification.create!(
      body: message,
      user_id: user_id
    )
  end

  def prepare_file
    JSON.parse(File.read(path)) rescue nil
  end

  def prepare_objects
    content.delete_at(0)
    content.map!{ |row| { title: row[0], author: row[1], category_id: row[2] }}
  end

  def create_records
    Book.transaction do
      Book.create!(content)
    end
  end

  def delete_file
    File.delete(path)
  end
end