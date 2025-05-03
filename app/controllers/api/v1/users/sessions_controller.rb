# app/controllers/api/v1/users/sessions_controller.rb
module Api
  module V1
    module Users
      class SessionsController < ApplicationController
        skip_before_action :verify_authenticity_token

        def create
          # Find user by email
          user = User.find_by(email: params[:user][:email])

          if user&.valid_password?(params[:user][:password])
            # Check if user is active
            if user.active?
              sign_in(user)  # Sign in the user using Devise
              render json: {
                message: "Logged in successfully.",
                user: {
                  id: user.id,
                  email: user.email,
                  first_name: user.first_name,
                  last_name: user.last_name
                }
              }, status: :ok
            else
              render json: { error: "Account is not active." }, status: :unauthorized
            end
          else
            render json: { error: "Invalid email or password." }, status: :unauthorized
          end
        end

        def destroy
          # Logout the user by signing out
          if current_user
            sign_out(current_user)
            render json: { message: "Logged out successfully." }, status: :ok
          else
            render json: { error: "No user logged in." }, status: :unauthorized
          end
        end
      end
    end
  end
end
