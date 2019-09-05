class AddSuffixToLanguages < ActiveRecord::Migration[5.2]
  def change
    add_column :languages, :suffix, :string
  end
end
