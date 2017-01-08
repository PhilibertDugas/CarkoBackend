class AddCompleteToParking < ActiveRecord::Migration[5.0]
  def change
    add_column :parkings, :is_complete, :bool
  end
end
