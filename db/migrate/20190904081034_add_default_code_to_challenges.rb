class AddDefaultCodeToChallenges < ActiveRecord::Migration[5.2]
  def change
    add_column :challenges, :default_code, :text
  end
end
