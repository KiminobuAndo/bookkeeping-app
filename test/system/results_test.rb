require "application_system_test_case"

class ResultsTest < ApplicationSystemTestCase
  test "completing all questions shows result page" do
    user = User.create!(name: "テストユーザー", email: "result@example.com", password: "password")
    course = Course.create!(name: "テストコース", is_published: true)
    question = course.questions.create!(prompt: "現金を受け取った。現金は？", correct_side: :debit)

    sign_in_as(user)
    visit start_quiz_path(course_id: course.id)

    choose "answer[selected_side]", option: "debit"
    click_button "回答する"

    assert_current_path result_path(Result.last)
    assert_text "試験結果"
  end

  test "result page shows total_score and correct_count" do
    user = User.create!(name: "テストユーザー", email: "score@example.com", password: "password")
    course = Course.create!(name: "テストコース", is_published: true)
    course.questions.create!(prompt: "現金を受け取った。現金は？", correct_side: :debit)

    sign_in_as(user)
    visit start_quiz_path(course_id: course.id)
    choose "answer[selected_side]", option: "debit"
    click_button "回答する"

    result = Result.last
    assert_text result.total_score.to_s
    assert_text "正解数"
  end

  test "result page has link to dashboard" do
    user = User.create!(name: "テストユーザー", email: "back@example.com", password: "password")
    course = Course.create!(name: "テストコース", is_published: true)
    course.questions.create!(prompt: "現金を受け取った。現金は？", correct_side: :debit)

    sign_in_as(user)
    visit start_quiz_path(course_id: course.id)
    choose "answer[selected_side]", option: "debit"
    click_button "回答する"

    click_on "トップに戻る"
    assert_current_path dashboard_path
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
