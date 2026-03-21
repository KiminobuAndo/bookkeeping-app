require "application_system_test_case"

class DashboardTest < ApplicationSystemTestCase
  test "dashboard is accessible after login" do
    user = User.create!(
      name: "テストユーザー",
      email: "dashboard@example.com",
      password: "password"
    )

    sign_in_as(user)

    assert_current_path dashboard_path
  end

  test "published courses appear on dashboard" do
    user = User.create!(
      name: "テストユーザー",
      email: "courses@example.com",
      password: "password"
    )
    course = Course.create!(name: "借方・貸方 現金勘定どっち？？", is_published: true)

    sign_in_as(user)
    visit dashboard_path

    assert_text course.name
  end

  test "unpublished courses do not appear on dashboard" do
    user = User.create!(
      name: "テストユーザー",
      email: "draft@example.com",
      password: "password"
    )
    Course.create!(name: "未公開コース", is_published: false)

    sign_in_as(user)
    visit dashboard_path

    assert_no_text "未公開コース"
  end

  test "dashboard redirects to login when not authenticated" do
    visit dashboard_path
    assert_current_path new_user_session_path
  end

  private

  def sign_in_as(user)
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: "password"
    click_on "ログイン"
  end
end
