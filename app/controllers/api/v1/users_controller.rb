# app/controllers/api/v1/users_controller.rb
module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!
      before_action :check_admin, only: [:manage_users, :report_users]
      before_action :set_user, only: [:show, :update]

      def index
        users = User.all
        render json: users
      end

      def show
        render json: @user
      end

      def update
        if @user.update(user_params)
          if params[:user][:avatar].present?
            response = Cloudinary::Uploader.upload(params[:user][:avatar], folder: "avatars")
            @user.update(avatar_public_id: response["public_id"])
          end
          render json: @user
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def profile
        render json: current_user
      end

      def update_profile
        if current_user.update(user_params)
          if params[:user][:avatar].present?
            response = Cloudinary::Uploader.upload(params[:user][:avatar], folder: "avatars")
            current_user.update(avatar_public_id: response["public_id"])
          end
          render json: current_user
        else
          render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def manage_users
        users = User.page(params[:page]).per(10)
        render json: users
      end

      def report_users
        users = User.page(params[:page]).per(10)
        render json: users
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def check_admin
        unless current_user.has_role?(:admin)
          render json: { error: 'Access denied' }, status: :forbidden
        end
      end

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :password, :password_confirmation, :avatar)
      end
    end
  end
end
