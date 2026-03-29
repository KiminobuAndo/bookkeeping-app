require "application_system_test_case"

class ResultsTest < ApplicationSystemTestCase
  test "completing all questions shows result page" do
    user = User.create!(name: "チEトユーザー", email: "result@example.com", password: "password")
    course = Course.create!(name: "チEトコース", is_published: true)
    question = course.questions.create!(prompt: "現金を受け取った。現金EEE", correct_side: :debit)

    sign_in_as(user)
    visit start_quiz_path(course_id: course.id)

    choose "answer[selected_side]", option: "debit"
    click_button "回答する"

    assert_current_path result_path(Result.last)
    assert_text "試験結果"
  end

  test "result page shows total_score and correct_count" do
    user = User.create!(name: "チEトユーザー", email: "score@example.com", password: "password")
    course = Course.create!(name: "チEトコース", is_published: true)
    course.questions.create!(prompt: "現金を受け取った。現金EEE", correct_side: :debit)

    sign_in_as(user)
    visit start_quiz_path(course_id: course.id)
    choose "answer[selected_side]", option: "debit"
    click_button "回答する"

    result = Result.last
    assert_text result.total_score.to_s
    assert_text "正解数"
  end

  test "result page has link to dashboard" do
    user = User.create!(name: "チEトユーザー", email: "back@example.com", password: "password")
    course = Course.create!(name: "チEトコース", is_published: true)
    course.questions.create!(prompt: "現金を受け取った。現金EEE", correct_side: :debit)

    sign_in_as(user)
    visit start_quiz_path(course_id: course.id)
    choose "answer[selected_side]", option: "debit"
    click_button "回答する"

    click_on "トップに戻る"
    assert_current_path dashboard_path
  end

  test "quiz uses only 10 random questions even when more exist" do
    user = User.create!(name: "random ten", email: "random10@example.com", password: "password")
    course = Course.create!(name: "random course", is_published: true)

    12.times do |index|
      course.questions.create!(prompt: "question #{index}", correct_side: :debit)
    end

    sign_in_as(user)
    visit start_quiz_path(course_id: course.id)

    10.times do
      choose "answer[selected_side]", option: "debit"
      click_button "回答する"
    end

    result = Result.last
    assert_current_path result_path(result)
    assert_equal 10, result.result_details.count
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
