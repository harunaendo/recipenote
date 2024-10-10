class User::UsersController < ApplicationController
  before_action :set_user, only: [:favorites]

  def index
    @user = current_user
    @recipes = @user.recipes.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_users_path
    end
  end

  def show
    @user = User.find(params[:id])
    @recipes = @user.recipes.page(params[:page])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       redirect_to user_users_path
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

  def favorites
    #@user = User.find(params[:id])
    #@recipes = @user.recipes
    favorites = Favorite.where(user_id: @user.id).pluck(:recipe_id)
    @favorite_recipes = Recipe.find(favorites)
    @favorites = @user.favorites.page(params[:page])
  end

  def followings
   user = User.find(params[:id])
   @users = user.following_users
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_users
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
