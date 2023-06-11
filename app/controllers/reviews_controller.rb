class ReviewsController < ApplicationController
  include SessionsHelper
  
  def create
    @book = Book.find_by(id: params[:book_id])
    if Review.find_by(user_id: current_user.id, book_id: @book.id)
      flash[:danger] = 'すでにレビュー済みです'
      return render 'books/show'
    end  
    
    @review = current_user.reviews.build(comment_params)
    if @review.save
      flash[:success] = 'レビューを投稿しました'
    else
      flash[:danger] = '投稿に失敗しました'
    end
    redirect_to book_path(@book)
  end
  
  def destroy
    @book = Book.find_by(id: params[:book_id])
    
    unless Review.find_by(user_id: current_user.id, book_id: @book.id)
      flash[:danger] = 'レビューがありません'
      return render 'books/show'
    end
      
    if Review.find_by(user_id: current_user.id, book_id: @book.id).destroy
      flash[:success] = 'レビューを削除しました'
    else
      flash[:danger] = 'レビュー削除に失敗しました'
    end
    redirect_to book_path(@book)
  end
  
  
  private
  
  def comment_params
    params.require(:review).permit(:comment).merge(book_id: @book.id)
  end
  
end