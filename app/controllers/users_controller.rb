class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  include SessionsHelper
  
  def index
    @users = User.all.page(params[:page]).per(10)
  end
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find_by(id: params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = '登録に成功しました'
      redirect_to @user
    else
      flash.now[:danger] = '登録に失敗しました'
      render "new"
    end
  end
  
  def edit
  end
  
  def update
    @user.assign_attributes(user_params)
    if @user.save
      flash[:success] = '更新に成功しました'
      redirect_to @user
    else
      flash.now[:danger] = '更新に失敗しました'
      render "edit"
    end
  end
  
  def destroy
    User.find_by(id: params[:id]).destroy!
    redirect_to users_url
  end
  
  private
  
  def logged_in_user
    unless logged_in?
      store_url
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end
  
  def correct_user
    @user = User.find_by(id: params[:id])
    if current_user != @user
      flash[:danger] = '他人のユーザー情報を編集することはできません'
      redirect_to root_url
    end
  end  
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
