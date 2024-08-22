class User::UsersController < ApplicationController
  def index
    @user = current_user
    @recipes = @user.recipes
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_users_path(@user.id)
    else
      render :edit
    end
  end

  def check
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to new_user_registration_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
