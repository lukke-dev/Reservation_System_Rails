class ApplicationController < ActionController::Base
	before_action :authenticate_user!

	include ChooseLayout
	include DeviseWhitelist
end