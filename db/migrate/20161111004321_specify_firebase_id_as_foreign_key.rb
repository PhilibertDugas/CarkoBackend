class SpecifyFirebaseIdAsForeignKey < ActiveRecord::Migration[5.0]
  def change
    remove_column :parkings, :customer_id
    add_column :parkings, :customer_firebase_id, :string
  end
end
