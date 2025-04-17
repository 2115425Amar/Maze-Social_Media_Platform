# app/controllers/api/v1/posts_controller.rb
module Api
  module V1
    class PostsController < ApplicationController
      # before_action :authenticate_user!
      before_action :set_post, only: %i[show update destroy]
      before_action :authorize_post, only: %i[show update destroy]

      def index
        if params[:user_id]
          user = User.find_by(id: params[:user_id])
          return render json: { error: "User not found" }, status: :not_found unless user

          posts = user.posts.includes(:comments).order(created_at: :desc)
        else
          posts = if current_user.has_role?(:admin)
                    Post.includes(:user, :comments).order(created_at: :desc)
                  else
                    Post.where(public: true).or(Post.where(user: current_user)).order(created_at: :desc)
                  end
        end

        render json: posts, include: [:user, :comments], status: :ok
      end

      def show
        render json: @post, include: [:comments], status: :ok
      end

      def create
        post = current_user.posts.build(post_params)
        if post.save
          render json: post, status: :created
        else
          render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @post.update(post_params)
          render json: @post, status: :ok
        else
          render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if current_user.has_role?(:admin) || @post.user == current_user
          @post.destroy
          head :no_content
        else
          render json: { error: "Not authorized to delete this post" }, status: :forbidden
        end
      end

      private

      def set_post
        @post = Post.find_by(id: params[:id])
        render json: { error: "Post not found" }, status: :not_found unless @post
      end

      def post_params
        params.require(:post).permit(:description, :public)
      end

      def authorize_post
        unless @post.public? || @post.user == current_user || current_user.has_role?(:admin)
          render json: { error: "Not authorized" }, status: :forbidden
        end
      end
    end
  end
end
