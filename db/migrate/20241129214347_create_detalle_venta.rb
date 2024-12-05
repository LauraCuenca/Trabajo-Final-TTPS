class CreateDetalleVenta < ActiveRecord::Migration[8.0]
  def change
    create_table :detalle_venta do |t|
      t.references :venta, null: false, foreign_key: true
      t.references :producto, null: false, foreign_key: true
      t.integer :cantidad
      t.decimal :precio_venta

      t.timestamps
    end
  end
end
