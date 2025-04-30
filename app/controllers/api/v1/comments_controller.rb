def create
  @post = Post.find(params[:post_id])
  @comment = @post.comments.build(comment_params)
  @comment.user = current_user

  if @comment.save
    render json: { message: "Comment added!", comment: @comment }, status: :created
  else
    render json: { error: "Comment could not be created", reasons: @comment.errors.full_messages }, status: :unprocessable_entity
  end
end
