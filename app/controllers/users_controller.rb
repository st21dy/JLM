class UsersController < ApplicationController

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
    @users = user.following_user.page(params[:page]).reverse_order
    
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).reverse_order
    
  end
  
  def likes
    @User = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user_id)
    
  end
  
  def unsubscribe
    
  end
  
  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用お待ちしております。"
    redirect_to root_path
    
  end
  

  private

  def user_params
    params.require(:user).permit(:name, :icon, :body)
  end


end
