class DashboardController < ApplicationController
  layout "dashboard"

  QUIZ_QUESTION_LIMIT = 10

  def index
    @courses = Course.published.order(:created_at)
  end

  def start_quiz
    course_id = params[:course_id]
    if course_id.blank?
      redirect_to dashboard_path, alert: "コースを選択してください" and return
    end

    course = Course.find(course_id)
    question_ids = course.questions.order(Arel.sql("RANDOM()")).limit(QUIZ_QUESTION_LIMIT).pluck(:id)
    if question_ids.empty?
      redirect_to dashboard_path, alert: "こEコースには問題がありません" and return
    end

    result = current_user.results.create!(course: course)
    session[:current_result_id] = result.id
    session[:remaining_question_ids] = question_ids
    redirect_to question_path(question_ids.first)
  end
end
