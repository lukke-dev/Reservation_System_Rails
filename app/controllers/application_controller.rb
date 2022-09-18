class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	include ChooseLayout
	include DeviseWhitelist
	include AuthorizeResource

	rescue_from CanCan::AccessDenied do |exception|
		redirect_to '/', :alert => exception.message
	end

end