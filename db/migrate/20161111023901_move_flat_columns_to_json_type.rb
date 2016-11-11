class MoveFlatColumnsToJsonType < ActiveRecord::Migration[5.0]
  def change
    remove_column :parkings, :start_time
    remove_column :parkings, :stop_time
    remove_column :parkings, :always_available
    remove_column :parkings, :days_available
    add_column :parkings, :availability_info, :json
  end
end
