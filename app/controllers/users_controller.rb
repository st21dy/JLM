class UsersController < ApplicationController
  before_action :set_user, only: [:likes, :show, :edit, :update,]

  def show
    @articles = @user.articles.page(params[:page]).reverse_order
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def follows # フォロー
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).reverse_order
  end

  def followers # フォロワー
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).reverse_order
  end

  def likes # いいねした投稿
    likes = Like.where(user_id: @user.id).pluck(:article_id)
    @like_articles = Article.find(likes)
  end

  def unsubscribe
  end

  def withdraw # 退会機能
    @user = current_user
    @user.update(is_deleted: true)

    reset_session
    flash[:notice] = "ありがとうございました。またのご利用お待ちしております。"
    redirect_to root_path
  end

  def search
    @users = User.search(params[:keyword])
    @keyword = params[:keyword]
    render search_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :icon, :body)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
