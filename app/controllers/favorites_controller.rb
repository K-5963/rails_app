class FavoritesController < ApplicationController
  include SessionsHelper
  
  def create
    if Favorite.find_by(user_id: current_user.id, book_id: params[:id])
      flash[:danger] = 'すでにいいね済みです'
      redirect_to book_path
    else
      Favorite.new(user_id: current_user.id, book_id: params[:id]).save
      flash[:success] = 'いいねしました'
      redirect_to book_path
    end
  end
  
  def destroy
    if Favorite.find_by(user_id: current_user.id, book_id: params[:id]).destroy!
      flash[:success] = 'いいね解除しました'
      redirect_to favorites_user_path
    else
      flash[:danger] = 'いいね解除に失敗しました'
      redirect_to book_path
    end
  end
  
end