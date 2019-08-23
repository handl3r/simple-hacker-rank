class Challenge < ApplicationRecord
  # Validates =========================
  validates :title, presence: true
  validates :content, presence: true
  validates :question, presence: true
  # Associations =======================
  belongs_to :groupchallenge
  has_many :users, through: :passlevel
  has_one :testcase
end
