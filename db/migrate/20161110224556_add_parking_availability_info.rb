class AddParkingAvailabilityInfo < ActiveRecord::Migration[5.0]
  def change
    change_table :parkings do |t|
      t.column :start_time, :time
      t.column :stop_time, :time
      t.column :always_available, :boolean
      t.column :days_available, :integer, array: true
    end
  end
end
