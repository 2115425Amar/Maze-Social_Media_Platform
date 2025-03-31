require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  # include Devise::Test::ControllerHelpers  # <-- Include Devise helpers


  let(:user) { create(:user) }  # Regular user
  let(:admin) { create(:user, :admin) } # Admin user

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user] # Fix Devise mapping
    sign_in user  # Devise helper to simulate user login
  end

  describe "GET #index" do
    context "when user is an admin" do
      before do
        sign_out user
        sign_in admin
        get :index
      end

      it "returns a successful response" do
        expect(response).to have_http_status(:success)
      end

      it "assigns @users" do
        expect(assigns(:users)).to be_present
      end
    end

    context "when user is not an admin" do
      before { get :index }

      it "redirects to root_path" do
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("Access denied")
      end
    end
  end

  describe "GET #profile" do
    it "returns a successful response" do
      get :profile
      expect(response).to have_http_status(:success)
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "PATCH #update_profile" do
    context "with valid attributes" do
      it "updates the user profile" do
        patch :update_profile, params: { user: { first_name: "Updated" } }
        user.reload
        expect(user.first_name).to eq("Updated")
        expect(response).to redirect_to(profile_path)
      end
    end

    context "with invalid attributes" do
      it "renders the profile template" do
        patch :update_profile, params: { user: { email: "invalid-email" } }
        expect(response).to render_template(:profile)
      end
    end
  end

  describe "GET #manage_users" do
    context "when user is an admin" do
      before do
        sign_out user
        sign_in admin
        get :manage_users
      end

      it "returns a successful response" do
        expect(response).to have_http_status(:success)
      end
    end

    context "when user is not an admin" do
      before { get :manage_users }

      it "redirects to root_path" do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #report_users" do
    context "when user is an admin" do
      before do
        sign_out user
        sign_in admin
        get :report_users
      end

      it "returns a successful response" do
        expect(response).to have_http_status(:success)
      end
    end

    context "when user is not an admin" do
      before { get :report_users }

      it "redirects to root_path" do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
