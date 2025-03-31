require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    User.destroy_all  # Ensure no duplicate users exist
    @user = User.new(
      first_name: "John",
      last_name: "Doe",
      email: "john.doe@example.com",
      phone_number: "1234567890",
      password: "password",
      password_confirmation: "password"
    )
  end

  # test "should be valid" do
  #   assert @user.valid?
  # end
  
  test "should be valid" do
    assert @user.valid?, @user.errors.full_messages.join(", ")
  end
  

  test "first name should be present" do
    @user.first_name = ""
    assert_not @user.valid?
  end

  test "last name should be present" do
    @user.last_name = ""
    assert_not @user.valid?
  end

  test "email should be present and unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should have valid format" do
    @user.email = "invalid_email"
    assert_not @user.valid?
  end

  test "phone number should be present, unique and 10 digits" do
    @user.phone_number = ""
    assert_not @user.valid?

    @user.phone_number = "12345"
    assert_not @user.valid?

    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "should have many posts, likes, and comments" do
    assert_respond_to @user, :posts
    assert_respond_to @user, :likes
    assert_respond_to @user, :comments
  end

  test "should assign default role after create" do
    @user.save
    assert @user.has_role?(:user)
  end

  test "name method should return full name" do
    assert_equal "John Doe", @user.name
  end

  test "active? should return user active status" do
    @user.active = true
    assert @user.active?
  end

  test "admin? should return true if user has admin role" do
    @user.save
    @user.add_role(:admin)
    assert @user.admin?
  end

  # test "avatar_url should return default image if no avatar is uploaded" do
  #   assert_match /imageavatar.jpg/, @user.avatar_url
  # end

  test "avatar_url should return default image if no avatar is uploaded" do
    expected_asset_path = ActionController::Base.helpers.asset_path("imageavatar.jpg")
    assert_equal expected_asset_path, @user.avatar_url
  end

end
