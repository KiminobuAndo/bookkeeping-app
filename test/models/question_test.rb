require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  setup do
    @course = Course.create!(title: "現金の仕訳")
  end

  test "valid with required attributes" do
    q = Question.new(course: @course, prompt: "商品を現金で購入した", correct_side: :debit)
    assert q.valid?
  end

  test "invalid without prompt" do
    q = Question.new(course: @course, correct_side: :debit)
    assert_not q.valid?
    assert q.errors[:prompt].any?
  end

  test "invalid without correct_side" do
    q = Question.new(course: @course, prompt: "商品を現金で購入した")
    assert_not q.valid?
  end

  test "invalid without course" do
    q = Question.new(prompt: "商品を現金で購入した", correct_side: :debit)
    assert_not q.valid?
  end

  test "correct_side enum has debit and credit" do
    assert_equal({ "debit" => "debit", "credit" => "credit" }, Question.correct_sides)
  end
end
