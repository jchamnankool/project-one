class AddHeartsToEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :hearts, :text, array: true, default: []
  end
end
