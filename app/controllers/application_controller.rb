class ApplicationController < ActionController::Base
  before_action :authenticate_admin!, if: :admin_url

  def admin_url
    request.fullpath.include?("/admin")
  end

  def after_sign_in_path_for(resource)
     user_users_path
  end

  def after_sign_out_path_for(resource)
    user_root_path(current_user)
  end

  def delete
    if user.save
      flash[:notice] = 'Signed out successfully.'
      redirect_to user_root_path
    else
      render :new
    end
  end

 private
  def set_header
    if admin_signed_in?
      @header = 'admin'
    elsif user_signed_in?
      @header = 'user'
    else
      @header = 'guest'
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

end
