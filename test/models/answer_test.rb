require "test_helper"

class AnswerTest < ActiveSupport::TestCase
  test "valid with all required attributes" do
    answer = Answer.new(
      user: users(:one),
      question: questions(:one),
      selected_side: :debit
    )
    assert answer.valid?
  end

  test "invalid without selected_side" do
    answer = Answer.new(user: users(:one), question: questions(:one))
    assert_not answer.valid?
    assert answer.errors[:selected_side].any?
  end

  test "invalid without user" do
    answer = Answer.new(question: questions(:one), selected_side: :debit)
    assert_not answer.valid?
  end

  test "invalid without question" do
    answer = Answer.new(user: users(:one), selected_side: :debit)
    assert_not answer.valid?
  end

  test "correct? returns true when selected_side matches correct_side" do
    answer = answers(:correct_answer)
    assert answer.correct?
  end

  test "correct? returns false when selected_side does not match correct_side" do
    answer = answers(:wrong_answer)
    assert_not answer.correct?
  end

  test "debit? predicate works" do
    answer = answers(:correct_answer)
    assert answer.debit?
    assert_not answer.credit?
  end

  test "valid without input_amount" do
    answer = Answer.new(user: users(:one), question: questions(:one), selected_side: :debit)
    assert answer.valid?
  end

  test "invalid with negative input_amount" do
    answer = Answer.new(user: users(:one), question: questions(:one), selected_side: :debit, input_amount: -1)
    assert_not answer.valid?
    assert answer.errors[:input_amount].any?
  end

  test "invalid with non-integer input_amount" do
    answer = Answer.new(user: users(:one), question: questions(:one), selected_side: :debit, input_amount: 1.5)
    assert_not answer.valid?
    assert answer.errors[:input_amount].any?
  end

  test "amount_correct? returns true when input_amount matches correct_amount" do
    answer = answers(:correct_answer)
    assert answer.amount_correct?
  end

  test "amount_correct? returns false when input_amount does not match correct_amount" do
    answer = Answer.new(user: users(:one), question: questions(:one), selected_side: :debit, input_amount: 999)
    assert_not answer.amount_correct?
  end

  test "amount_correct? returns true when question has no correct_amount" do
    answer = Answer.new(user: users(:one), question: questions(:two), selected_side: :debit)
    assert answer.amount_correct?
  end
end
