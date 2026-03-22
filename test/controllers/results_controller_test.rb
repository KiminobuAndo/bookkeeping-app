require "test_helper"

class ResultsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @result = results(:one)
    sign_in @user
  end

  test "show returns 200 for own result" do
    get result_path(@result)
    assert_response :success
  end

  test "show redirects to dashboard for another user's result" do
    other_user = User.create!(name: "他のユーザー", email: "other@example.com", password: "password")
    other_result = other_user.results.create!(course: courses(:cash_course))
    get result_path(other_result)
    assert_redirected_to dashboard_path
  end

  test "show redirects to login when not authenticated" do
    sign_out @user
    get result_path(@result)
    assert_redirected_to new_user_session_path
  end
end
