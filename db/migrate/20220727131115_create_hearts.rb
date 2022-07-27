class CreateHearts < ActiveRecord::Migration[5.2]
  def change
    create_table :hearts do |t|
      t.text :user_name
      t.integer :user_id
      t.integer :entry_id

      t.timestamps
    end
  end
end
