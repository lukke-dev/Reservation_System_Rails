module ApplicationHelper
	include Pagy::Frontend

	def set_name
		current_user.is_admin ? I18n.t('administrator') : current_user.name
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

  def set_active
    action = params[:action] == 'import' ? 'import' : 'index'
    action = params[:action] if ['users/registrations', 'home'].include?(params[:controller])
    status = current_page?(controller: params[:controller], action: action) ? 'active' : ''
    "breadcrumb-item link-breadcrumb #{status}"
  end

  def set_path_csv(path)
    path + '.csv'
  end

  def set_query_to_change(id)
    params = request.fullpath.split('?')[1] || 'q%5Bbooking_date_date_equals%5D=&q%5Breturn_date_date_equals%5D=&q%5Buser_id_eq%5D=&q%5Bbook_id_eq%5D=&q%5Bbooking_status_eq%5D='
    "#{reservation_change_status_path(id)}?#{params}"
  end
end