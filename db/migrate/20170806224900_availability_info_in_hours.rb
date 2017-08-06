class AvailabilityInfoInHours < ActiveRecord::Migration[5.1]
  def change
    remove_column :parking_availability_info, :start_time
    remove_column :parking_availability_info, :stop_time
    add_column :parking_availability_info, :start_hour, :string
    add_column :parking_availability_info, :stop_hour, :string
  end
end
