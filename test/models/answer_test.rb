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
end
