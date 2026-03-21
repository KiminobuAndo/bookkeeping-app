class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  enum :selected_side, { debit: "debit", credit: "credit" }

  validates :selected_side, presence: true

  def correct?
    selected_side == question.correct_side
  end
end
