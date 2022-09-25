class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification:#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end
