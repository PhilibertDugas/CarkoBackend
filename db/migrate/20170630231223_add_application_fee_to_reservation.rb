class AddApplicationFeeToReservation < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :application_fee, :float
  end
end
