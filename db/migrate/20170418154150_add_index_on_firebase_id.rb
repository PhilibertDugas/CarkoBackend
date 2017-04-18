class AddIndexOnFirebaseId < ActiveRecord::Migration[5.0]
  def change
    add_index 'customers', ['firebase_id'], name: 'index_firebase_id'
  end
end
