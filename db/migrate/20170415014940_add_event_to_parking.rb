class AddEventToParking < ActiveRecord::Migration[5.0]
  def change
    add_column :parkings, :event_id, :integer
    add_index 'parkings', ['event_id'], name: 'index_event_id'
    change_column :events, :price, 'money USING price::numeric::money'
  end
end
