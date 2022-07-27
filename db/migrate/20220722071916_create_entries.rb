class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.text :tidbits, array: true, default: []
      t.integer :user_id

      t.timestamps
    end
  end
end
