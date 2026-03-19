require "application_system_test_case"

class AuthTest < ApplicationSystemTestCase
  test "user can sign up" do
    visit new_user_registration_path

    fill_in "表示名", with: "新規ユーザー"
    fill_in "メールアドレス", with: "new@example.com"
    fill_in "パスワード", match: :first, with: "password"
    fill_in "パスワード（確認）", with: "password"
    click_on "登録する"

    assert_text "新規ユーザー さん"
  end

  test "user can log in and log out" do
    User.create!(name: "テストユーザー", email: "test@example.com", password: "password")

    visit new_user_session_path

    fill_in "メールアドレス", with: "test@example.com"
    fill_in "パスワード", with: "password"
    click_on "ログイン"

    assert_text "テストユーザー さん"

    click_on "ログアウト"

    assert_text "ログイン"
  end

  test "home page is accessible without login" do
    visit root_path
    assert_current_path root_path
  end
end
