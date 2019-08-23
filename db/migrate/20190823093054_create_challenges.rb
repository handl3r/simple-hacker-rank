class CreateChallenges < ActiveRecord::Migration[5.2]
  def change
    create_table :challenges do |t|
      t.string :title
      t.string :content
      t.string :question
      t.references :groupchallenge, foreign_key: true

      t.timestamps
    end
  end
end
