# frozen_string_literal: true

class User < ApplicationRecord
  # Validates ===========================
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: true }
  validates :name, uniqueness: true, presence: true
  validates :admin, inclusion: { in: [true, false] }
  validates :password_digest, presence: true, length: { minimum: 6 }
  # Associations ==============================
  has_many :passlevels
  has_many :challenges, :through => :passlevels
end
