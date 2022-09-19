class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	include SetLocale
	include ChooseLayout
	include DeviseWhitelist
	include AuthorizeResource
	include Pagy::Backend

	rescue_from CanCan::AccessDenied do |exception|
		redirect_to '/', :alert => exception.message
	end
end