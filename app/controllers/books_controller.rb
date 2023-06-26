class BooksController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update, :destroy]
  include SessionsHelper
  
  def index
    @books = current_user.books.page(params[:page]).per(10)
  end

  def new
    @book = current_user.books.build
  end

  def show
    @book = Book.find_by(id: params[:id])
    @review = Review.new
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:success] = '登録に成功しました'
      redirect_to @book
    else
      flash.now[:danger] = '登録に失敗しました'
      render "new"
    end
  end

  def edit
  end

  def update
    @book.assign_attributes(book_params)
    if @book.save
      flash[:success] = '更新に成功しました'
      redirect_to @book
    else
      flash.now[:danger] = '更新に失敗しました'
      render "edit"
    end
  end

  def destroy
    Book.find_by(id: params[:id]).destroy!
    redirect_to books_url
  end
  
  private
  
  def book_params
    params.require(:book).permit(:name, :description, :summary, :impression)
  end
  
  def logged_in_user
    unless logged_in?
      store_url
      flash[:danger] = 'ログインしてください'
      redirect_to login_url
    end
  end
  
  def correct_user
    @book = Book.find_by(id: params[:id])
    if current_user != @book.user
      flash[:danger] = '他人の本の情報を編集することはできません'
      redirect_to books_url
    end
  end
  
end
