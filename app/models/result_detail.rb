class ResultDetail < ApplicationRecord
  belongs_to :result
  belongs_to :question

  enum :answer_side, { debit: "debit", credit: "credit" }

  validates :answer_side, presence: true
  validates :is_correct, inclusion: { in: [ true, false ] }
  validates :score, presence: true
end
