class FavoritesController < ApplicationController
  include SessionsHelper
  
  def create
    @book = Book.find_by(id: params[:book_id])
    if Favorite.find_by(user_id: current_user.id, book_id: params[:book_id])
      flash[:danger] = 'すでにいいね済みです'
      redirect_to book_path(@book)
    else
      Favorite.create!(user_id: current_user.id, book_id: params[:book_id])
      flash[:success] = 'いいねしました'
      redirect_to book_path(@book)
    end
  end
  
  def destroy
    if Favorite.find_by(user_id: current_user.id, book_id: params[:book_id]).destroy
      flash[:success] = 'いいね解除しました'
      redirect_to favorites_user_path(current_user)
    else
      flash[:danger] = 'いいね解除に失敗しました'
      redirect_to book_path(params[:book_id])
    end
  end
  
end