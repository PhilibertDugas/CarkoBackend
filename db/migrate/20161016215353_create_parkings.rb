class CreateParkings < ActiveRecord::Migration[5.0]
  def change
    create_table :parkings do |t|
      t.float :latitude
      t.float :longitude
      t.string :photourl
      t.money :price
      t.string :address
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
