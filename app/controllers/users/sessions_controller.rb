class Users::SessionsController < Devise::SessionsController
	def after_sign_in_path_for(resource_or_scope)
		return dashboard_path if resource_or_scope.is_admin
		super
	end
end

