class AddDefaultValue < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :balance, :decimal, default: 50000.00
  end
end
