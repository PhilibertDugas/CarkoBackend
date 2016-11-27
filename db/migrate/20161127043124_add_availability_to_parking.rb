class AddAvailabilityToParking < ActiveRecord::Migration[5.0]
  def change
    add_column :parkings, :is_available, :boolean
  end
end
