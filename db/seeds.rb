# frozen_string_literal: true

require 'faker'

# Make normal user
(0..50).each do |i|
  User.create(name: "test#{i}", email: "test#{i}@email.com",
              password: '111111',
              password_confirmation: '111111')
end
# Make group Challenge
(0..5).each do |i|
  Groupchallenge.create(level: i, name: "Level #{i}")
end
# Make challenge
(0..100).each do |i|
  Challenge.create(title: "Title #{i}", content: "Content #{i}",
                   question: "question #{i}",
                   groupchallenge_id: (0..5).to_a.sample)
end
# Make Passlevel
users = User.all
users_pass = users[1..30]
# challenges_pass = Challenge.all[1..80]
users_pass.each do |user|
  number_pass_challenge = rand(1..80)
  (1..number_pass_challenge).each do |number_pass|
    Passlevel.create(user_id: user.id, challenge_id: number_pass)
  end
end
# Make testcase for each challenge
Challenge.all.each do |challenge|
  rand(1..5).times do
    Testcase.create(input: rand(1..10).to_s, output: rand(1..20).to_s,
                    challenge_id: challenge.id)
  end

end
# Update default-code for challenges
# Challenge.all.each do |challenge|
#   challenge.default_code =
# end

# Make language
Language.create(name: 'ruby', suffix: '.rb')
Language.create(name: 'python3', suffix: '.py')
Language.create(name: 'java', suffix: '.java')
Language.create(name: 'cplus', suffix: '.cpp')
Language.create(name: 'go', suffix: '.go')

# Make default code for each challenge and language
Challenge.all.each do |challenge|
  default_code_ruby = "def mainMethod()\nend"
  Defaultcode.create(challenge: challenge,
                     language: Language.find_by(name: 'ruby'),
                     code: default_code_ruby)

  default_code_python = "def mainMethod():\n"
  Defaultcode.create(challenge: challenge,
                     language: Language.find_by(name: 'python3'),
                     code: default_code_python)
end


# Make user admin
AdminUser.create!(email: 'admin@email.com', password: '111111', password_confirmation: '111111') if Rails.env.development?