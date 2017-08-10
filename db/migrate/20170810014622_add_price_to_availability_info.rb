class AddPriceToAvailabilityInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :parking_availability_infos, :price, :float
  end
end
