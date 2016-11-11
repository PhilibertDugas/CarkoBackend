class AddParkingDescription < ActiveRecord::Migration[5.0]
  def change
    rename_column :parkings, :photourl, :photo_url
    change_column :parkings, :start_time, :string
    change_column :parkings, :stop_time, :string
    add_column :parkings, :description, :string
  end
end
