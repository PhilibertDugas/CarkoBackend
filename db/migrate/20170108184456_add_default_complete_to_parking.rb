class AddDefaultCompleteToParking < ActiveRecord::Migration[5.0]
  def change
    remove_column :parkings, :is_complete
    add_column :parkings, :is_complete, :boolean, default: false
  end
end
