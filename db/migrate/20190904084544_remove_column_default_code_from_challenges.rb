class RemoveColumnDefaultCodeFromChallenges < ActiveRecord::Migration[5.2]
  def change
    remove_column :challenges, :default_code
  end
end
