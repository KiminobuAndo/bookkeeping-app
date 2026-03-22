require "test_helper"

class AnswerGraderTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @course = Course.create!(name: "テストコース", is_published: true)
  end

  # --- grade (両方一致で true) ---

  test "grade returns true when side and amount both match" do
    question = @course.questions.create!(prompt: "問題", correct_side: :debit, correct_amount: 100)
    answer = Answer.new(user: @user, question: question, selected_side: :debit, input_amount: 100)
    assert AnswerGrader.new(answer).grade
  end

  test "grade returns false when side does not match" do
    question = @course.questions.create!(prompt: "問題", correct_side: :debit, correct_amount: 100)
    answer = Answer.new(user: @user, question: question, selected_side: :credit, input_amount: 100)
    assert_not AnswerGrader.new(answer).grade
  end

  test "grade returns false when amount does not match" do
    question = @course.questions.create!(prompt: "問題", correct_side: :debit, correct_amount: 100)
    answer = Answer.new(user: @user, question: question, selected_side: :debit, input_amount: 200)
    assert_not AnswerGrader.new(answer).grade
  end

  test "grade returns false when both side and amount do not match" do
    question = @course.questions.create!(prompt: "問題", correct_side: :debit, correct_amount: 100)
    answer = Answer.new(user: @user, question: question, selected_side: :credit, input_amount: 200)
    assert_not AnswerGrader.new(answer).grade
  end

  test "grade returns true when side matches and correct_amount is nil" do
    question = @course.questions.create!(prompt: "問題", correct_side: :debit)
    answer = Answer.new(user: @user, question: question, selected_side: :debit, input_amount: nil)
    assert AnswerGrader.new(answer).grade
  end

  test "grade returns true when side matches and both amounts are nil" do
    question = @course.questions.create!(prompt: "問題", correct_side: :debit)
    answer = Answer.new(user: @user, question: question, selected_side: :debit)
    assert AnswerGrader.new(answer).grade
  end

  test "grade returns false when side matches but input_amount is nil and correct_amount is set" do
    question = @course.questions.create!(prompt: "問題", correct_side: :debit, correct_amount: 100)
    answer = Answer.new(user: @user, question: question, selected_side: :debit, input_amount: nil)
    assert_not AnswerGrader.new(answer).grade
  end

  # --- side_correct? ---

  test "side_correct? returns true when debit matches debit" do
    question = @course.questions.create!(prompt: "問題", correct_side: :debit)
    answer = Answer.new(user: @user, question: question, selected_side: :debit)
    assert AnswerGrader.new(answer).side_correct?
  end

  test "side_correct? returns false when debit does not match credit" do
    question = @course.questions.create!(prompt: "問題", correct_side: :credit)
    answer = Answer.new(user: @user, question: question, selected_side: :debit)
    assert_not AnswerGrader.new(answer).side_correct?
  end

  # --- amount_correct? ---

  test "amount_correct? returns true when amounts match" do
    question = @course.questions.create!(prompt: "問題", correct_side: :debit, correct_amount: 500)
    answer = Answer.new(user: @user, question: question, selected_side: :debit, input_amount: 500)
    assert AnswerGrader.new(answer).amount_correct?
  end

  test "amount_correct? returns false when amounts do not match" do
    question = @course.questions.create!(prompt: "問題", correct_side: :debit, correct_amount: 500)
    answer = Answer.new(user: @user, question: question, selected_side: :debit, input_amount: 300)
    assert_not AnswerGrader.new(answer).amount_correct?
  end

  test "amount_correct? returns true when correct_amount is nil" do
    question = @course.questions.create!(prompt: "問題", correct_side: :debit)
    answer = Answer.new(user: @user, question: question, selected_side: :debit)
    assert AnswerGrader.new(answer).amount_correct?
  end
end
