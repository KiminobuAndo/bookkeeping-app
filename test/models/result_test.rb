require "test_helper"

class ResultTest < ActiveSupport::TestCase
  setup do
    @result = results(:one)
  end

  test "valid with required attributes" do
    assert @result.valid?
  end

  test "belongs to user" do
    assert_equal users(:one), @result.user
  end

  test "belongs to course" do
    assert_equal courses(:cash_course), @result.course
  end

  test "has many result_details" do
    assert_equal 2, @result.result_details.count
  end

  test "invalid without user" do
    result = Result.new(course: courses(:cash_course))
    assert_not result.valid?
  end

  test "invalid without course" do
    result = Result.new(user: users(:one))
    assert_not result.valid?
  end
end
