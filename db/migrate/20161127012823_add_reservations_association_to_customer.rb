class AddReservationsAssociationToCustomer < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :customer_id, :integer
    add_index 'reservations', ['customer_id'], name: 'index_customer_id'
  end
end
