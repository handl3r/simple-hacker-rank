class Challenge < ApplicationRecord
  # Validates =========================
  validates :title, presence: true
  validates :content, presence: true
  validates :question, presence: true
  # Associations =======================
  belongs_to :groupchallenge
  has_many :passlevels
  has_many :users, :through => :passlevels
  has_many :testcases
  has_many :defaultcodes
  has_many :successcodes
end
