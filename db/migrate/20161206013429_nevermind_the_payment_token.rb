class NevermindThePaymentToken < ActiveRecord::Migration[5.0]
  def change
    remove_column :reservations, :payment_token
  end
end
