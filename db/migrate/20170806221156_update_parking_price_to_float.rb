class UpdateParkingPriceToFloat < ActiveRecord::Migration[5.1]
  def change
    remove_column :parkings, :price
    add_column :parkings, :price, :float, default: 0.0
  end
end
