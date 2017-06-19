class AddDisplayName < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :display_name, :string, required: true
  end
end
