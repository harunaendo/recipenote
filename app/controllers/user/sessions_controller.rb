# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
   #before_action :configure_sign_in_params, only: [:create]
   before_action :user_state, only: [:create]

  def create
    super
  end

 protected

 def user_state
    @user = User.find_by(email: params[:user][:email]) #入力されたemailからアカウントを1件取得
    return if @user.nil? #アカウントを取得できなかった場合、このメソッドを終了
    return unless @user.valid_password?(params[:user][:password]) #取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了
    if @user.is_active == false
      flash[:alert] = "退会済みです。再度、新規登録をお願いいたします。"
      redirect_to new_user_registration_path
    end
 end

  def after_sign_in_path_for(resource)
    user_users_path(current_user)
  end

  def after_sign_out_path_for(resource)
    user_root_path
  end

#  def reject_end_user
#    @end_user = EndUser.find_by(email: params[:end_user][:email])
#    if @end_user
#      if @end_user.valid_password?(params[:end_user][:password]) && (@end_user.is_active == true)
#        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
#        redirect_to new_user_registration_path
#      else
#        flash[:notice] = "項目を入力してください"
#      end
#    else
#      flash[:notice] = "該当するユーザーが見つかりません"
#    end
#  end

  # GET /resource/sign_in
#   def create
#     super
#   end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

 # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
