class ChangeReservationToTimestamps < ActiveRecord::Migration[5.0]
  def change
    change_column :reservations, :start_time, "timestamp USING start_time::timestamp without time zone"
    change_column :reservations, :stop_time, "timestamp USING start_time::timestamp without time zone"
  end
end
