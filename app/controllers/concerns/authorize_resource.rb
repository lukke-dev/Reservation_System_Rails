module AuthorizeResource
	extend ActiveSupport::Concern
	WHITELIST = %w[ sessions passwords registrations ].freeze

  included do
    load_and_authorize_resource unless: :verify_controller
  end

  def verify_controller
    WHITELIST.each{ |c| return true if params[:controller].include?(c) }
		false
  end
end