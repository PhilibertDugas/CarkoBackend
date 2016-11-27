class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.boolean :is_active
      t.string :start_time
      t.string :stop_time

      t.timestamps
    end
  end
end
