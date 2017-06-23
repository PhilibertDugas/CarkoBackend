class ConvertMoneyToFloat < ActiveRecord::Migration[5.1]
  def change
   change_column :events, :price, "float USING price::numeric::float8"
  end
end
