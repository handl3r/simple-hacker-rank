class Groupchallenge < ApplicationRecord
  # Validates =========================
  validates :level, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  # Associations ======================
  has_many :challenges
end
