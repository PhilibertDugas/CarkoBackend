class AddCustomerRevenueToReservation < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :customer_revenue, :float
  end
end
