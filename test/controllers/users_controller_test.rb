require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin = User.create!(
      first_name: "Admin",
      last_name: "User",
      email: "admin@example.com",
      phone_number: "1122334455",
      password: "adminpassword",
      password_confirmation: "adminpassword"
    )
    @admin.add_role(:admin)

    @user = User.create!(
      first_name: "Regular",
      last_name: "User",
      email: "user@example.com",
      phone_number: "9988776655",
      password: "userpassword",
      password_confirmation: "userpassword"
    )

    sign_in @admin # Ensure admin is signed in for testing
  end


  test "should get profile" do
    get profile_path
    assert_response :success
  end

  test "should update profile" do
    patch update_profile_path, params: { user: { first_name: "NewName" } }
    assert_redirected_to profile_path
    @admin.reload
    assert_equal "NewName", @admin.first_name
  end

  test "should not allow non-admins to access index" do
    sign_out @admin
    sign_in @user
    get users_path
    assert_redirected_to root_path
    assert_equal "Access denied", flash[:alert]
  end

  test "should allow admin to access index" do
    get users_path
    assert_response :success
  end

  test "should allow admin to manage users" do
    get manage_users_path
    assert_response :success
  end

  test "should allow admin to report users" do
    get report_users_path
    assert_response :success
  end

  test "should prevent non-admins from managing users" do
    sign_out @admin
    sign_in @user
    get manage_users_path
    assert_redirected_to root_path
    assert_equal "Access denied", flash[:alert]
  end

  test "should prevent non-admins from reporting users" do
    sign_out @admin
    sign_in @user
    get report_users_path
    assert_redirected_to root_path
    assert_equal "Access denied", flash[:alert]
  end
end
