class AddPhotoUrlArrayToParking < ActiveRecord::Migration[5.1]
  def change
    add_column :parkings, :multiple_photo_urls, :string, array: true, default: []
  end
end
