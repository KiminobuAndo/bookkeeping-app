require "test_helper"

class ResultDetailTest < ActiveSupport::TestCase
  test "valid with required attributes" do
    assert result_details(:one).valid?
  end

  test "invalid without answer_side" do
    detail = ResultDetail.new(result: results(:one), question: questions(:one), is_correct: true, score: 5)
    assert_not detail.valid?
    assert detail.errors[:answer_side].any?
  end

  test "invalid with wrong is_correct value" do
    detail = ResultDetail.new(result: results(:one), question: questions(:one), answer_side: :debit, is_correct: nil, score: 5)
    assert_not detail.valid?
  end

  test "invalid without result" do
    detail = ResultDetail.new(question: questions(:one), answer_side: :debit, is_correct: true, score: 5)
    assert_not detail.valid?
  end

  test "invalid without question" do
    detail = ResultDetail.new(result: results(:one), answer_side: :debit, is_correct: true, score: 5)
    assert_not detail.valid?
  end

  test "answer_side enum has debit and credit" do
    assert_equal({ "debit" => "debit", "credit" => "credit" }, ResultDetail.answer_sides)
  end
end
