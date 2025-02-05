class AddTotalStatusAndClientToSales < ActiveRecord::Migration[8.0]
  def change
    add_column :sales, :total_price, :decimal
    add_column :sales, :client_name, :string
  end
end
