module ApplicationHelper
	def set_name
		current_user.is_admin ? 'Administrator' : current_user.name
	end

	def set_button(icon, title, color)
		"<i class='fa fa-#{icon} text-#{color}' title='#{title}'></i>".html_safe
	end
end
