module LoadNotifications
	extend ActiveSupport::Concern
	
	included do
		before_action :load_notifications, if: :user_signed_in?
	end

	def load_notifications
		@notifications ||= current_user.notifications.unreads
	end
end