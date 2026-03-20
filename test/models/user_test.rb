require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid with name, email, and password" do
    user = User.new(name: "テストユーザー", email: "user@example.com", password: "password")
    assert user.valid?
  end

  test "invalid without name" do
    user = User.new(email: "user@example.com", password: "password")
    assert_not user.valid?
    assert user.errors[:name].any?
  end

  test "invalid with name too long" do
    user = User.new(name: "a" * 51, email: "user@example.com", password: "password")
    assert_not user.valid?
    assert user.errors[:name].any?
  end

  test "invalid without email" do
    user = User.new(name: "テストユーザー", password: "password")
    assert_not user.valid?
    assert user.errors[:email].any?
  end
end
