class DashboardController < ApplicationController
  layout "dashboard"

  def index
    @courses = Course.published.order(:created_at)
  end

  def start_quiz
    course_id = params[:course_id]
    if course_id.blank?
      redirect_to dashboard_path, alert: "コースを選択してください" and return
    end
    course = Course.find(course_id)
    question = course.questions.order(:created_at).first
    if question.nil?
      redirect_to dashboard_path, alert: "このコースには問題がありません"
    else
      redirect_to question_path(question)
    end
  end
end
