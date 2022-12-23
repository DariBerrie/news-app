class PostsController < ApplicationController
  before_action :set_post, only: %i[show]
  def index
    @posts = Post.all.with_rich_text_content_and_embeds
  end

  def show
    @comment = Comment.new
    @comments = Comment.where(post_id: @post.id).order(created_at: :desc)
  end

  def my_posts
    @user_posts = Post.where(user: current_user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post), notice: "Your post was successfully published."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :url, photos:[])
  end
end
