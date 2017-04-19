class AddPhotoUrlToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :photo_url, :string
    add_column :events, :target_audience, :integer
  end
end
