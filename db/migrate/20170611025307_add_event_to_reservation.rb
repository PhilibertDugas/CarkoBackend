class AddEventToReservation < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :event_id, :integer
    add_index 'reservations', ['event_id'], name: 'index_reservation_event_id'
  end
end
