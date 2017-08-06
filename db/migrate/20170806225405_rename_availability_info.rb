class RenameAvailabilityInfo < ActiveRecord::Migration[5.1]
  def change
    rename_table :parking_availability_info, :parking_availability_infos
  end
end
