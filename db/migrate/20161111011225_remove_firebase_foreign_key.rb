class RemoveFirebaseForeignKey < ActiveRecord::Migration[5.0]
  def change
    remove_column :parkings, :customer_firebase_id
    add_column :parkings, :customer_id, :integer
    add_foreign_key :parkings, :customers
  end
end
