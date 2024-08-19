class User::UsersController < ApplicationController
  def index
    @user = current_user
    @recipes = @user.recipes
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_recipes_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
