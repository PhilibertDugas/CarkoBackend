class CleanupOldColumns < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :label
    remove_column :parkings, :event_id
  end
end
