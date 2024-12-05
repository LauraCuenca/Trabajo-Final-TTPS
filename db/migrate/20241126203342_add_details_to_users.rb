class AddDetailsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :username, :string
    add_column :users, :phone, :string
    add_column :users, :role, :string
    add_column :users, :joined_on, :date
  end
end
