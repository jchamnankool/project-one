class DeleteStreakFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :streak
  end
end
