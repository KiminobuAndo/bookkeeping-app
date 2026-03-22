require "application_system_test_case"

class QuestionsTest < ApplicationSystemTestCase
  test "question page shows form after login" do
    user = User.create!(name: "テストユーザー", email: "question@example.com", password: "password")
    course = Course.create!(name: "現金コース", is_published: true)
    question = course.questions.create!(prompt: "現金を受け取った。現金は？", correct_side: :debit)

    sign_in_as(user)
    visit question_path(question)

    assert_text question.prompt
    assert_selector "input[type='radio'][value='debit']"
    assert_selector "input[type='radio'][value='credit']"
    assert_selector "input[type='number']"
    assert_button "回答する"
  end

  test "submitting a valid answer redirects to dashboard" do
    user = User.create!(name: "テストユーザー", email: "submit@example.com", password: "password")
    course = Course.create!(name: "現金コース", is_published: true)
    question = course.questions.create!(prompt: "現金を受け取った。現金は？", correct_side: :debit)

    sign_in_as(user)
    visit question_path(question)

    choose "answer[selected_side]", option: "debit"
    fill_in "answer[input_amount]", with: "100"
    click_button "回答する"

    assert_current_path dashboard_path
    assert_text "回答を送信しました"
  end

  test "submitting without selecting side shows error" do
    user = User.create!(name: "テストユーザー", email: "error@example.com", password: "password")
    course = Course.create!(name: "現金コース", is_published: true)
    question = course.questions.create!(prompt: "現金を受け取った。現金は？", correct_side: :debit)

    sign_in_as(user)
    visit question_path(question)

    click_button "回答する"

    assert_text "入力内容を確認してください"
  end

  test "question page redirects to login when not authenticated" do
    course = Course.create!(name: "現金コース", is_published: true)
    question = course.questions.create!(prompt: "現金を受け取った。現金は？", correct_side: :debit)

    visit question_path(question)

    assert_current_path new_user_session_path
  end

  private

  def sign_in_as(user)
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: "password"
    click_button "ログイン"
    assert_current_path dashboard_path
  end
end
