class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :label
      t.float :latitude
      t.float :longitude
      t.integer :range
      t.float :price
      t.timestamp :start_time
      t.timestamp :end_time

      t.timestamps
    end
  end
end
