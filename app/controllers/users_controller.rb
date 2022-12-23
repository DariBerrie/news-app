class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user_posts = Post.where(user: @user)
  end
end
