class CustomerEmailUnique < ActiveRecord::Migration[5.0]
  def change
    add_index :customers, :email, unique: true
  end
end
