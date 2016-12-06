class CreateVehicules < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicules do |t|
      t.string :license_plate
      t.string :make
      t.string :model
      t.string :year
      t.string :color
      t.string :province
      t.integer :customer_id

      t.timestamps
    end

    add_column :customers, :vehicule_id, :integer
    add_column :reservations, :vehicule_id, :integer
  end
end
