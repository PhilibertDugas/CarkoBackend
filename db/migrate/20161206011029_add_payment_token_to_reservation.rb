class AddPaymentTokenToReservation < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :payment_token, :string
    add_index 'reservations', ['vehicule_id'], name: 'index_reservation_vehicule_id'
    add_index 'customers', ['vehicule_id'], name: 'index_customer_vehicule_id'
    add_index 'vehicules', ['customer_id'], name: 'index_vehicule_customer_id'
  end
end
