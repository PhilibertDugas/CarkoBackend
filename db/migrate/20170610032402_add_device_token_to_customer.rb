class AddDeviceTokenToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :token, :string
  end
end
