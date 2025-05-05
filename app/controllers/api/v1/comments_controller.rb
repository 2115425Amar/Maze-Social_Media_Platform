module Api
  module V1
    class CommentsController < ApplicationController
      def index
        render json: { message: "index action works!" }
      end

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
      
      # Add other actions here
    end
  end
end


