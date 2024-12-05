class CreateVenta < ActiveRecord::Migration[8.0]
  def change
    create_table :venta do |t|
      t.datetime :fecha
      t.integer :id_empleado
      t.string :estado

      t.timestamps
    end
  end
end
