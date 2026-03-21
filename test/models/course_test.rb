require "test_helper"

class CourseTest < ActiveSupport::TestCase
  test "valid with name" do
    course = Course.new(name: "現金の仕訳")
    assert course.valid?
  end

  test "invalid without name" do
    course = Course.new
    assert_not course.valid?
    assert course.errors[:name].any?
  end

  test "has many questions" do
    course = Course.create!(name: "現金の仕訳")
    course.questions.create!(prompt: "商品を購入した", correct_side: :debit)
    assert_equal 1, course.questions.count
  end

  test "published scope returns only published courses" do
    Course.create!(name: "公開コース", is_published: true)
    Course.create!(name: "未公開コース", is_published: false)
    assert Course.published.all? { |c| c.is_published }
  end
end
