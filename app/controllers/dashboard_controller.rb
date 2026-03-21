class DashboardController < ApplicationController
  layout "dashboard"

  def index
    @courses = Course.published.order(:created_at)
  end

  def start_quiz
    course_id = params[:course_id]
    redirect_to dashboard_path, alert: "コースを選択してください" if course_id.blank?
  end
end