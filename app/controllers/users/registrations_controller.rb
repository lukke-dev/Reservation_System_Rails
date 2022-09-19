class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication, only: %i[ new create ]

  def new
    unless warden.authenticate? && current_user.is_admin
      redirect_to new_user_session_path
    else
      super
    end
  end

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        respond_with resource, location: after_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
end
