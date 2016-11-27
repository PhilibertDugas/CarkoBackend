class AddPricePaidToReservation < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :total_cost, :float
    add_index 'parkings', ['customer_id'], name: 'index_parking_customer_id'
  end
end
