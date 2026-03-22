class Result < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :result_details, dependent: :destroy

  validates :total_score, :correct_count, :total_time_seconds, presence: true
end
