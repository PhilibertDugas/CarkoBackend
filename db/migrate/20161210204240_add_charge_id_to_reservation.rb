class AddChargeIdToReservation < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :charge, :string
  end
end
