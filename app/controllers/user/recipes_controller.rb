class User::RecipesController < ApplicationController
  before_action :authenticate_user!

  def new
#    unless user.id == current_user.id
#    redirect_to post_images_path
#  end
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    if @recipe.save
      flash[:notice] = "投稿完了"
      @user = current_user
      redirect_to user_users_path
    else
      render :new
    end
  end

  def index
    @user = current_user
    @recipes = Recipe.page(params[:page])
  end

  def favorites
    #@user = User.find(params[:id])
    #@recipes = @user.recipes
    #@recipes = Recipe.find(params[:id])
    #favorites = Favorite.where(user_id: @user.id).pluck(:recipe_id)
    #@favorite_recipes = Recipe.find(favorites)
    #@favorites = @user.favorites.page(params[:page])
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:recipe_id)
    @favorite_recipes = Recipe.find(favorites)
    @recipe = Recipe.find(params[:id])
    @recipes = Recipes.page(params[:page])
  end


  def edit
    @recipe = Recipe.find(params[:id])
    if @recipe.user == current_user
      render "edit"
    else
      redirect_to user_recipes_path
    end

  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_comment = RecipeComment.new
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
       redirect_to user_recipe_path
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to user_users_path
  end

  private
  def recipe_params
    params.require(:recipe).permit(:title, :body, :image)
  end
end
