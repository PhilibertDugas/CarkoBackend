class IMessedUp < ActiveRecord::Migration[5.1]
  def change
    remove_column :reservations, :label
    add_column :events, :label, :string
  end
end
