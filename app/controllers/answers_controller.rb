class AnswersController < ApplicationController
  def create
    @answer = current_user.answers.build(answer_params)
    @answer.is_correct = AnswerGrader.new(@answer).grade
    if @answer.save
      result = Result.find_by(id: session[:current_result_id])
      if result
        score = @answer.is_correct ? 5 : 0
        result.result_details.create!(
          question: @answer.question,
          answer_side: @answer.selected_side,
          is_correct: @answer.is_correct,
          elapsed_seconds: nil,
          score: score
        )
        result.increment!(:correct_count) if @answer.is_correct
        result.increment!(:total_score, score)

        remaining = session[:remaining_question_ids].to_a
        remaining.delete(@answer.question_id)
        session[:remaining_question_ids] = remaining

        if remaining.any?
          redirect_to question_path(remaining.first)
        else
          session.delete(:current_result_id)
          session.delete(:remaining_question_ids)
          redirect_to result_path(result)
        end
      else
        redirect_to dashboard_path, notice: "回答を送信しました"
      end
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
