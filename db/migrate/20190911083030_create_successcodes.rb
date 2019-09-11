class CreateSuccesscodes < ActiveRecord::Migration[5.2]
  def change
    create_table :successcodes do |t|
      t.references :user, foreign_key: true
      t.references :challenge, foreign_key: true
      t.references :language, foreign_key: true
      t.text :code

      t.timestamps
    end
  end
end
