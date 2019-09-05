class CreateDefaultcodes < ActiveRecord::Migration[5.2]
  def change
    create_table :defaultcodes do |t|
      t.references :challenge, foreign_key: true
      t.references :language, foreign_key: true
      t.text :code

      t.timestamps
    end
  end
end
