class Testcase < ApplicationRecord
  # Validates =======================
  validates :input, presence: true
  validates :output, presence: true, allow_blank: true
  validates :challenge_id, presence: true
  # Associations ====================
  belongs_to :challenge
end
