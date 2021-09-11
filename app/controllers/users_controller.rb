class UsersController < ApplicationController
  before_action :set_user, only: [:likes]

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.page(params[:page]).reverse_order
    @following_users = @user.following_user
    @follower_users = @user.follower_user

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)

  end

  def follows
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end
  
  def likes
    likes = Like.where(user_id: @user.id).pluck(:article_id)
    @like_articles = Article.find(likes)
  end
  

  private

  def user_params
    params.require(:user).permit(:name, :icon, :body)
  end
  
  def set_user
    @user = User.find(params[:id])
  end


end
