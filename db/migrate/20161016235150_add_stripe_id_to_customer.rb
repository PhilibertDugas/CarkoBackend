class AddStripeIdToCustomer < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :stripe_id, :string
  end
end
