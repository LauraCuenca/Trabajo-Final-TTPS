class AddColumnsToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :inventory_entry_date, :datetime
    add_column :products, :deleted_at, :datetime
  end
end
