class CommentsController < ApplicationController
  before_action :set_post, only: :create
  def create
    @comment = Comment.create(comment_params)
    @comment.post = @post
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: "Your comment was successfully published." }
        format.json
      else
        format.html { redirect_to post_path(@post), notice: "Your comment did not save." }
        format.json
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
