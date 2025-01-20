class CreateSales < ActiveRecord::Migration[8.0]
  def change
    create_table :sales do |t|
      t.datetime :date
      t.integer :employee_id
      t.string :status

      t.timestamps
    end
  end
end
