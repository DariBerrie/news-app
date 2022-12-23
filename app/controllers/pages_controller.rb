class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @posts = Post.all.with_rich_text_content.order(created_at: :desc)
  end
end
