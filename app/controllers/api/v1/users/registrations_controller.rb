module Api
  module V1
    module Users
      class RegistrationsController < ApplicationController
        skip_before_action :verify_authenticity_token
        before_action :configure_permitted_parameters, only: [:create]

        def create
          user = User.new(user_params)
          if user.save
            send_welcome_email(user)
            render json: { message: "Registration successful! Please check your email.", user: user }, status: :created
          else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
          end
        end

        private

        def user_params
          params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation, :avatar)
        end

        def configure_permitted_parameters
          # No need for API-specific configurations here since params are manually permitted.
        end

        def send_welcome_email(user)
          UserMailer.welcome_email(user).deliver_later
        rescue RedisClient::CannotConnectError, Errno::ECONNREFUSED => e
          Rails.logger.error "Sidekiq is not running or Redis is unavailable: #{e.message}"
          UserMailer.welcome_email(user).deliver_now
        end
      end
    end
  end
end
