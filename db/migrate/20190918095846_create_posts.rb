class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.references :category_post, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
