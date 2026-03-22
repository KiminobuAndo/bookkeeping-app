class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  enum :selected_side, { debit: "debit", credit: "credit" }

  validates :selected_side, presence: true
  validates :input_amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  def correct?
    selected_side == question.correct_side
  end

  def amount_correct?
    return true if question.correct_amount.nil?

    input_amount == question.correct_amount
  end
end
