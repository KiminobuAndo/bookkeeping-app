require "test_helper"

class CourseTest < ActiveSupport::TestCase
  test "valid with title" do
    course = Course.new(title: "現金の仕訳")
    assert course.valid?
  end

  test "invalid without title" do
    course = Course.new
    assert_not course.valid?
    assert course.errors[:title].any?
  end

  test "has many questions" do
    course = Course.create!(title: "現金の仕訳")
    course.questions.create!(prompt: "商品を購入した", correct_side: :debit)
    assert_equal 1, course.questions.count
  end
end
