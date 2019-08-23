# frozen_string_literal: true

class Passlevel < ApplicationRecord
  # Associations ========================
  belongs_to :user
  belongs_to :challenge
end
