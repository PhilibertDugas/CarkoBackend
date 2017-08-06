class ParkingAvailabilityCreation < ActiveRecord::Migration[5.1]
  def change
    create_table :parking_availability_info do |t|
      t.boolean :sunday_available
      t.boolean :monday_available
      t.boolean :tuesday_available
      t.boolean :wednesday_available
      t.boolean :thursday_available
      t.boolean :friday_available
      t.boolean :saturday_available
      t.timestamp :start_time
      t.timestamp :stop_time

      t.references :parking
      t.timestamps
    end
  end
end
