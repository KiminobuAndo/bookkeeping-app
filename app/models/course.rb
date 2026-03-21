class Course < ApplicationRecord
  has_many :questions, dependent: :destroy

  scope :published, -> { where(is_published: true) }

  validates :name, presence: true
end
