class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :email
      t.date :dob
      t.integer :streak

      t.timestamps
    end
  end
end
