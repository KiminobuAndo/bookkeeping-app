class Course < ApplicationRecord
  has_many :questions, dependent: :destroy

  validates :title, presence: true
end
