class Question < ApplicationRecord
  belongs_to :course

  enum :correct_side, { debit: "debit", credit: "credit" }

  validates :prompt, presence: true
  validates :correct_side, presence: true
end
