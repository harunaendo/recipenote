class User::FavoritesController < ApplicationController
  before_action :authenticate_user!
  def create
    recipe = Recipe.find(params[:recipe_id])
    favorite = current_user.favorites.new(recipe_id: recipe.id)
    favorite.save
    redirect_to user_recipe_path(recipe)
  end

  def destroy
    recipe = Recipe.find(params[:recipe_id])
    favorite = current_user.favorites.find_by(recipe_id: recipe.id)
    favorite.destroy
    redirect_to user_recipe_path(recipe)
  end

  def favorites
    @favorites = Favorite.page(params[:page])
  end
end
