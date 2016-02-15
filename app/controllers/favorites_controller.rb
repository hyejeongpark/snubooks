class FavoritesController < ApplicationController
  def index
    @title = "My favorites"
    post_ids = Favorite.where(:user => current_user).select(:post_id)
    @posts = Post.where(:id => post_ids).order(:updated_at => :desc).page(params[:page])

    render "posts/_posts_form"
  end

  def create
    favorite = Favorite.new(:user => current_user, :post_id => params[:favorite][:post_id])
    favorite.save

    redirect_to :back
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy

    redirect_to :back
  end
end
