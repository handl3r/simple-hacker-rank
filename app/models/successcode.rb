class Successcode < ApplicationRecord
  belongs_to :user
  belongs_to :challenge
  belongs_to :language
  validates :language_id, uniqueness: { scope: [:user_id, :challenge_id] }
  # This method to save submit code if it is not existing before or update new code to it
  def check_invalid(code)
    if self.save # if this challenge is not solved before by this user with this language
      1
    else # if this challenge is existing and must be update
      successcode = Successcode.find_by(user_id: self.user_id,
                                        language: self.language,
                                        challenge: self.challenge)
      successcode.update_attributes(code: code)
    end
  end
end
