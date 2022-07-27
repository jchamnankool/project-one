class AddFollowingToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :following, :text, array: true, default: []
    add_column :users, :followers, :text, array: true, default: []
  end
end
