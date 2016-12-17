class AddRestrictedBankInfoToCustomer < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :bank_last_4_digits, :string
    add_column :customers, :bank_name, :string
  end
end
