# frozen_string_literal: true

class CategoryPost < ApplicationRecord
  validates :name, presence: true, uniqueness: true

end
