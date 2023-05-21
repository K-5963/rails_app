class FavoritesController < ApplicationController
  include SessionsHelper
  
  def create
    Favorite.new(user_id: current_user.id, book_id: params[:id]).save
    flash[:success] = 'いいねしました'
    redirect_to book_path
  end
  
  def destroy
    Favorite.find_by(user_id: current_user.id, book_id: params[:id]).destroy!
    flash[:success] = 'いいね解除しました'
    redirect_to favorited_books_path
  end
  
end