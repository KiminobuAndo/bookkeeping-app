class AnswerGrader
  def initialize(answer)
    @answer = answer
    @question = answer.question
  end

  def grade
    side_correct? && amount_correct?
  end

  def side_correct?
    @answer.selected_side == @question.correct_side
  end

  def amount_correct?
    return true if @question.correct_amount.nil?

    @answer.input_amount == @question.correct_amount
  end
end
