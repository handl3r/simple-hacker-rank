# frozen_string_literal: true

require 'faker'

# Make normal user
(0..50).each do |i|
  User.create(name: "test#{i}", email: "test#{i}@email.com", admin: false,
              password_digest: '111111')
end
# Make admin user
User.create(name: 'admin', email: 'admin@gmail.com', admin: true,
            password_digest: '111111')
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
challenges_pass = Challenge.all[1..80]
users_pass.each do |user|
  number_pass_challenge = rand(1..80)
  (1..number_pass_challenge).each do |number_pass|
    Passlevel.create(user_id: user.id, challenge_id: number_pass)
  end
end
# Make testcase for each challenge
Challenge.all.each do |challenge|
  Testcase.create(input: (rand(1..10)).to_s, output: (rand(1..20)).to_s,
                  challenge_id: challenge.id)
end
# Make language
5.times do
Language.create(name: Faker::ProgrammingLanguage.unique.name)
end