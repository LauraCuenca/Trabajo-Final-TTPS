class CreateProductos < ActiveRecord::Migration[8.0]
  def change
    create_table :productos do |t|
      t.string :nombre
      t.text :descripcion
      t.decimal :precio
      t.integer :stock
      t.string :categoria
      t.string :talle
      t.string :color

      t.timestamps
    end
  end
end
