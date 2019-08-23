class Passlevel < ApplicationRecord
  belongs_to :user
  belongs_to :challenge
end
