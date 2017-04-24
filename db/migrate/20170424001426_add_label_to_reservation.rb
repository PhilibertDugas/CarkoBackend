class AddLabelToReservation < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :label, :string, default: ""
  end
end
