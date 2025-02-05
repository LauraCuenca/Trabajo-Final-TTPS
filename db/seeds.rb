# Desactivar la verificación de claves foráneas
ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = OFF;")
puts "Eliminando datos existentes..."

# Eliminar datos de las tablas
SaleItem.destroy_all
Sale.destroy_all
Product.destroy_all
User.destroy_all
Role.destroy_all

# Reiniciar la secuencia de IDs para cada tabla
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='sale_items';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='sales';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='products';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='users';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='roles';")

# Reactivar la verificación de claves foráneas
ActiveRecord::Base.connection.execute("PRAGMA foreign_keys = ON;")

puts "Datos eliminados y secuencias de IDs reiniciadas."

# Crear roles
Role.find_or_create_by(name: 'administrador')
Role.find_or_create_by(name: 'gerente')
Role.find_or_create_by(name: 'empleado')

# Crear usuarios
unless User.exists?(email: 'admin@gmail.com')
  user = User.new(
    username: "administrador_uno",
    email: 'admin@gmail.com',
    phone: "123456789",
    password: "password",
    password_confirmation: "password",
    joined_on: Date.today,
    active: true
  )
  role = Role.find_by(name: 'administrador')
  user.roles << role
  if user.save
    puts "administrador creado exitosamente: #{user.username}"
  else
    puts "Error al crear el usuario: #{user.errors.full_messages.to_sentence}"
  end
end

unless User.exists?(email: 'gerente@gmail.com')
  user = User.new(
    username: "gerente_uno",
    email: 'gerente@gmail.com',
    phone: "123456789",
    password: "password",
    password_confirmation: "password",
    joined_on: Date.today,
    active: true
  )
  role = Role.find_by(name: 'gerente')
  user.roles << role
  if user.save
    puts "gerente creado exitosamente: #{user.username}"
  else
    puts "Error al crear el usuario: #{user.errors.full_messages.to_sentence}"
  end
end

unless User.exists?(email: 'uno@gmail.com')
  user = User.new(
    username: "empleado_uno",
    email: "uno@gmail.com",
    phone: "123456789",
    password: "password",
    password_confirmation: "password",
    joined_on: Date.today,
    active: true
  )
  role = Role.find_by(name: 'empleado')
  user.roles << role
  if user.save
    puts "Usuario creado exitosamente: #{user.username}"
  else
    puts "Error al crear el usuario: #{user.errors.full_messages.to_sentence}"
  end
end

unless User.exists?(email: 'dos@gmail.com')
  user = User.new(
    username: "empleado_dos",
    email: "dos@gmail.com",
    phone: "123456789",
    password: "password",
    password_confirmation: "password",
    joined_on: Date.today,
    active: true
  )
  role = Role.find_by(name: 'empleado')
  user.roles << role
  if user.save
    puts "Usuario creado exitosamente: #{user.username}"
  else
    puts "Error al crear el usuario: #{user.errors.full_messages.to_sentence}"
  end
end

# Crear productos
products_data = [
  {
    name: "Remera Mao",
    price: 20000,
    description: "Remera top, mangas cortas negra",
    category: 'Mujer-Ropa',
    stock: 5,
    size: "M",
    color: "Negro",
    inventory_entry_date: Date.today,
    images: [ "remera.jpg" ]
  },
  {
    name: "Musculosa Jin",
    price: 25000,
    description: "Musculosa de tela viscosa",
    category: 'Mujer-Ropa',
    stock: 5,
    size: "L",
    color: "Lila",
    inventory_entry_date: Date.today,
    images: [ "musculosa.jpg" ]
  },
  {
    name: "Short Shorty",
    price: 15000,
    description: "Short sport de acetato",
    category: 'Mujer-Ropa',
    stock: 3,
    size: "S",
    color: "Negro",
    inventory_entry_date: Date.today,
    images: [ "short.jpg" ]
  },
  {
    name: "Calza Tie",
    price: 27000,
    description: "Calza de modal",
    category: 'Mujer-Ropa',
    stock: 4,
    size: "M",
    color: "Negro",
    inventory_entry_date: Date.today,
    images: [ "calza.jpg" ]
  },
  {
    name: "Zapatilla Nami",
    price: 55000,
    description: "Zapatilla para running",
    category: 'Mujer-Calzado',
    stock: 2,
    size: "37",
    color: "Negro",
    inventory_entry_date: Date.today,
    images: [ "n.jpeg" ]
  },
  {
    name: "Zapatilla Umi",
    price: 65000,
    description: "Zapatilla con plataforma",
    category: 'Mujer-Calzado',
    stock: 3,
    size: "38",
    color: "Rosa",
    inventory_entry_date: Date.today,
    images: [ "zapapink.jpg" ]
  },
  {
    name: "Remera Grey",
    price: 35000,
    description: "Remera de viscosa",
    category: 'Hombre-Ropa',
    stock: 5,
    size: "XL",
    color: "Gris",
    inventory_entry_date: Date.today,
    images: [ "remegris.jpg" ]
  },
  {
    name: "Remera Orange",
    price: 37000,
    description: "Remera de modal",
    category: 'Hombre-Ropa',
    stock: 2,
    size: "XL",
    color: "Naranja",
    inventory_entry_date: Date.today,
    images: [ "remenaranja.jpg" ]
  },
  {
    name: "Medias Blue",
    price: 37000,
    description: "Medias de compresion",
    category: 'Hombre-Ropa',
    stock: 7,
    size: "M",
    color: "Azul",
    inventory_entry_date: Date.today,
    images: [ "medias.jpg" ]
  },
  {
    name: "Short Kim",
    price: 17000,
    description: "Short de acetato",
    category: 'Hombre-Ropa',
    stock: 4,
    size: "L",
    color: "Blanco",
    inventory_entry_date: Date.today,
    images: [ "white.jpg" ]
  },
  {
    name: "Short Luffy",
    price: 19000,
    description: "Short de acetato",
    category: 'Hombre-Ropa',
    stock: 2,
    size: "M",
    color: "Negro",
    inventory_entry_date: Date.today,
    images: [ "black.jpg" ]
  },
  {
    name: "Zapatilla Zoro",
    price: 59000,
    description: "Zapatilla para running",
    category: 'Hombre-Calzado',
    stock: 3,
    size: "43",
    color: "Turquesa",
    inventory_entry_date: Date.today,
    images: [ "zapa2.jpeg" ]
  },
  {
    name: "Zapatilla Sanji",
    price: 59000,
    description: "Zapatilla para running",
    category: 'Hombre-Calzado',
    stock: 3,
    size: "44",
    color: "Negro",
    inventory_entry_date: Date.today,
    images: [ "zapanikie.jpeg" ]
  },
  {
    name: "Zapatilla Robin",
    price: 65000,
    description: "Zapatilla para running",
    category: 'Hombre-Calzado',
    stock: 2,
    size: "42",
    color: "Gris",
    inventory_entry_date: Date.today,
    images: [ "zapa1.png" ]
  },
  {
    name: "Conjunto kidy",
    price: 70000,
    description: "Conjunto de campera y pantalon",
    category: 'Niños-Ropa',
    stock: 3,
    size: "14",
    color: "Azul",
    inventory_entry_date: Date.today,
    images: [ "conjunto.jpg" ]
  },
  {
    name: "Zapatilla Zoe",
    price: 20000,
    description: "Zapatilla para niña",
    category: 'Niños-Calzado',
    stock: 2,
    size: "22",
    color: "Negro",
    inventory_entry_date: Date.today,
    images: [ "zapaniña.jpeg" ]
  },
  {
    name: "Zapatilla Marco",
    price: 22000,
    description: "Zapatilla para niño",
    category: 'Niños-Calzado',
    stock: 3,
    size: "22",
    color: "Negro",
    inventory_entry_date: Date.today,
    images: [ "zapaniño.jpeg" ]
  }
]

products_data.each do |product_data|
  product = Product.new(product_data.except(:images))

  product_data[:images].each do |image_filename|
    product.images.attach(
      io: File.open(Rails.root.join("app/assets/images/seeds", image_filename)),
      filename: image_filename,
      content_type: "image/jpeg"
    )
  end

  if product.save
    puts "Producto creado exitosamente: #{product.name}"
  else
    puts "Error al crear el producto #{product.name}: #{product.errors.full_messages.to_sentence}"
  end
end

employee = User.find_by(email: 'admin@gmail.com')
unless employee
  puts "Error: No se encontró un empleado con el correo 'admin@gmail.com'."
  return
end

product_1 = Product.find_by(name: 'Remera Mao')
product_2 = Product.find_by(name: 'Zapatilla Nami')
product_3 = Product.find_by(name: 'Musculosa Jin')
product_4 = Product.find_by(name: 'Short Shorty')

unless product_1 && product_2 && product_3 && product_4
  puts "Error: Uno o más productos no se encontraron en la base de datos."
  return
end

# Venta 1
sale_1 = Sale.new(
  client_name: 'Cliente 1',
  date: Date.today,
  status: 'active',
  employee_id: employee.id,
  total_price: 50000,
  sale_items_attributes: [
    {
      product_id: product_1.id,
      quantity: 2,
      price: 20000
    },
    {
      product_id: product_2.id,
      quantity: 1,
      price: 55000
    }
  ]
)
if sale_1.save
  puts "Venta 1 creada exitosamente."
else
  puts "Error al crear la venta 1: #{sale_1.errors.full_messages.to_sentence}"
end

# Venta 2
sale_2 = Sale.new(
  client_name: 'Cliente 2',
  date: Date.today,
  status: 'active',
  employee_id: employee.id,
  total_price: 40000,
  sale_items_attributes: [
    {
      product_id: product_3.id,
      quantity: 1,
      price: 25000
    },
    {
      product_id: product_4.id,
      quantity: 1,
      price: 15000
    }
  ]
)
if sale_2.save
  puts "Venta 2 creada exitosamente."
else
  puts "Error al crear la venta 2: #{sale_2.errors.full_messages.to_sentence}"
end
