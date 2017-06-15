class SoftDeleteParkings < ActiveRecord::Migration[5.1]
  def change
    add_column :parkings, :is_deleted, :boolean, default: false
  end
end
