# frozen_string_literal: true

class Language < ApplicationRecord
  # Validates ============================
  validates :name, presence: true, uniqueness: true
end
