class AddAccountIdToCustomer < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :account_id, :string
  end
end
