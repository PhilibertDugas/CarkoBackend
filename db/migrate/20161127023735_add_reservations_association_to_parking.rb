class AddReservationsAssociationToParking < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :parking_id, :integer
    add_index 'reservations', ['parking_id'], name: 'index_parking_id'
  end
end
