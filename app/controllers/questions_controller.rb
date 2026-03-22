class QuestionsController < ApplicationController
  layout "dashboard"

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
  end
end
