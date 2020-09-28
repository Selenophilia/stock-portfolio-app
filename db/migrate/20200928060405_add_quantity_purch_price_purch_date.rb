class AddQuantityPurchPricePurchDate < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :quantity, :integer
    add_column :transactions, :purchase_price,:decimal, precision: 10, scale: 2
    add_column :transactions, :purchase_date, :date
  end
end
