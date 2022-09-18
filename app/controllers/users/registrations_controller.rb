# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication, only: [:new]

  def new
    unless warden.authenticate? && current_user.is_admin
      redirect_to new_user_session_path
    else
      super
    end
  end
end
