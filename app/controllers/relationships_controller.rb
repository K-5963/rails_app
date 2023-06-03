class RelationshipsController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user
  before_action :correct_user
  
  def create
    if Relationship.find_by(follower_id: current_user.id, followed_id: params[:id])
      flash[:danger] = 'すでにフォロー済みです'
      redirect_to user_path
    else
      current_user.follow(params[:id])
      flash[:success] = 'フォローしました'
      redirect_to user_path
    end
  end
  
  def destroy
    if current_user.unfollow(params[:id])
      flash[:success] = 'フォロー解除しました'
      redirect_to user_path
    else
      flash[:danger] = 'フォロー解除に失敗しました'
      redirect_to user_path
    end
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
    if current_user == @user
      flash[:danger] = '自分をフォロー登録・解除することはできません'
      redirect_to user_path
    end
  end
end