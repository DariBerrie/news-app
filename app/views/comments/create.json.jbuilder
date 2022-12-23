if @comment.persisted?
  json.form render(partial: "shared/comment_form", formats: :html, locals: { post: @post, comment: Comment.new})
  json.inserted_comment render(partial: "posts/comment", formats: :html, locals: { comment: @comment })
else
  json.form render(partial: "shared/comment_form", formats: :html, locals: { post: @post, comment: @comment })
end
