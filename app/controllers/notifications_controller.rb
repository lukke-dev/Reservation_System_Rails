class NotificationsController < ApplicationController
  def clean
    Notification.find(params[:id]).destroy
    render json: { status: "success" }
  end

  def clean_all
    Notification.where(user_id: current_user.id, read: false).destroy_all
    render json: { status: "success" }
  end
end