class CreateTestcases < ActiveRecord::Migration[5.2]
  def change
    create_table :testcases do |t|
      t.string :input
      t.string :output
      t.references :challenge, foreign_key: true

      t.timestamps
    end
  end
end
