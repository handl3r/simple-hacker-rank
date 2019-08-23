class ChangeTypeColumnContent < ActiveRecord::Migration[5.2]
  def change
    change_column :challenges, :content, :text
    change_column :challenges, :question, :text
  end
end
