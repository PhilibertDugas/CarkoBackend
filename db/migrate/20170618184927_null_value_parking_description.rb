class NullValueParkingDescription < ActiveRecord::Migration[5.1]
  def change
    change_column :parkings, :description, :string, default: ""
  end
end
