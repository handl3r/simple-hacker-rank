# frozen_string_literal: true

class Passlevel < ApplicationRecord
  # Associations ========================
  belongs_to :user
  belongs_to :challenge
  validates :challenge_id, uniqueness: { scope: :user_id }
end
