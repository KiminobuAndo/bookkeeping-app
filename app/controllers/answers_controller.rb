class AnswersController < ApplicationController
  def create
    @answer = current_user.answers.build(answer_params)
    @answer.is_correct = AnswerGrader.new(@answer).grade
    if @answer.save
      redirect_to dashboard_path, notice: "回答を送信しました"
    else
      @question = @answer.question
      render "questions/show", status: :unprocessable_entity
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:question_id, :selected_side, :input_amount)
  end
end
