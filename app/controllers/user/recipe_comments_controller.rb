class User::RecipeCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    recipe = Recipe.find(params[:recipe_id])
    comment = current_user.recipe_comments.new(recipe_comment_params)
    comment.recipe_id = recipe.id
    comment.save
    redirect_to request.referer
  end

  def destroy
    RecipeComment.find_by(id: params[:id], recipe_id: params[:recipe_id]).destroy
    redirect_to request.referer
  end

  private
  def recipe_comment_params
    params.require(:recipe_comment).permit(:comment)
  end

end
