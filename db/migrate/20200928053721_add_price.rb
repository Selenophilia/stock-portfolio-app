class AddPrice < ActiveRecord::Migration[6.0]
  def change
    add_column :stocks, :price,:decimal, precision: 10, scale: 2
    add_column :stocks, :open_price,:decimal, precision: 10, scale: 2
  end
end
