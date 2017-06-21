class RemoveVehiculeIdFromReservation < ActiveRecord::Migration[5.1]
  def change
    remove_column :reservations, :vehicule_id
  end
end
