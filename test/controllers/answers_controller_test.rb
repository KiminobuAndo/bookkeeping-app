require "test_helper"

class AnswersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @question = questions(:one)
    sign_in @user
  end

  test "create with valid params redirects to dashboard" do
    post answers_path, params: {
      answer: { question_id: @question.id, selected_side: "debit", input_amount: 100 }
    }
    assert_redirected_to dashboard_path
    assert_equal "回答を送信しました", flash[:notice]
  end

  test "create saves is_correct true for correct answer" do
    post answers_path, params: {
      answer: { question_id: @question.id, selected_side: "debit", input_amount: 100 }
    }
    assert Answer.last.is_correct
  end

  test "create saves is_correct false for wrong side" do
    post answers_path, params: {
      answer: { question_id: @question.id, selected_side: "credit", input_amount: 100 }
    }
    assert_not Answer.last.is_correct
  end

  test "create saves is_correct false for wrong amount" do
    post answers_path, params: {
      answer: { question_id: @question.id, selected_side: "debit", input_amount: 999 }
    }
    assert_not Answer.last.is_correct
  end

  test "create without selected_side renders question show" do
    post answers_path, params: {
      answer: { question_id: @question.id, input_amount: 100 }
    }
    assert_response :unprocessable_entity
  end

  test "create without login redirects to sign in" do
    sign_out @user
    post answers_path, params: {
      answer: { question_id: @question.id, selected_side: "debit" }
    }
    assert_redirected_to new_user_session_path
  end
end
