module ApplicationHelper
	def set_name
		current_user.is_admin ? 'Administrator' : current_user.name
	end

	def set_button(icon, title, color)
		"<i class='fa fa-#{icon} text-#{color}' title='#{title}'></i>".html_safe
	end

	def toastr_flash
		flash.each_with_object([]) do |(type, message), flash_messages|
			type = 'success' if type == 'notice'
			type = 'error' if type == 'alert'
			if type == 'success' || type == 'error'
				text = "<script>toastr.#{type}('#{message}')</script>"
				flash_messages << text.html_safe if message
			end
		end.join("\n").html_safe
	end

	def active_sidebar
		cookies[:sidebar] == 'active' ? 'sidebar-toggled' : ''
	end

	def sidebar_class
		cookies[:sidebar] == 'active' ? 'toggled' : ''
	end
end