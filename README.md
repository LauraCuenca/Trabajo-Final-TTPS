# Trabajo Practico Final Integrador
### ``` TTPS - Opcion Ruby```
<br>
Una tienda online de ropa con gestión de empleados.
Este proyecto fue desarrollado como parte del trabajo final integrador de la materia TTPS. Utiliza Ruby on Rails como framework principal.

### ```Descripción del Proyecto```
Este proyecto es una tienda online de ropa que permite a los administradores gestionar productos y empleados, y a los clientes, navegar por los productos y realizar compras.

### ``` Funcionalidades principales:```
Gestión de productos:
 Crear, editar, listar y eliminar productos.<br>
Gestión de empleados:
 Registrar empleados y asignarles roles.<br>
Carrito de compras:
 Añadir productos, actualizar cantidades y finalizar la compra.<br>
Autenticación:
 Sistema de inicio de sesión para empleados,gerentes y administradores.<br>
Visualización de ventas:
 Los empleados pueden consultar ventas realizadas.

### ``` Características Principales```
Diseño responsive para garantizar una experiencia amigable en dispositivos móviles y de escritorio.
Sistema de roles para diferenciar entre usuarios y empleados.
Integración con Devise para manejo de autenticación.
Relación clara entre modelos (Productos, Ventas, Empleados, etc.).

### ``` Tecnologías Utilizadas```
- Lenguaje Backend: Ruby (versión 3.2.0)
- Framework: Ruby on Rails (versión 7.x)
- Base de Datos: PostgreSQL
- Front-End: HTML5, CSS3, Bootstrap
- Autenticación: Devise
- Otros:
    - Active Storage para la gestión de imágenes de productos.
    - Rails Admin para la gestión del administrador.

### ``` Requisitos Previos```
Antes de ejecutar el proyecto, asegúrate de tener instalados los siguientes componentes:

Ruby 3.2.0 o superior
Rails 7.x
PostgreSQL 12 o superior
Node.js y Yarn para gestionar paquetes front-end

### ``` Instalación y Ejecución```
Clona este repositorio en tu máquina local:
```bash
git clone https://github.com/tu_usuario/tu_repositorio.git
cd tu_repositorio
```
Instala las dependencias:
```bash
bundle install
yarn install
```
Configura la base de datos:
Edita el archivo config/database.yml con tus credenciales de PostgreSQL.
Crea y migra la base de datos:
```bash
rails db:create
rails db:migrate
```
Inicia el servidor:
```bash
rails server
Abre tu navegador y accede a http://localhost:3000.
```
### ``` Credenciales para iniciar sesion```
- Administrador: 
   usuario: admin@gmail.com
   contraseña: password
- Gerente:
  usuario: gerente@gmail.com
  contraseña: password
- Empleado:
  usuario: emp@gmail.com
  contraseña: password

### ``` Licencia```
Este proyecto se encuentra bajo la Licencia MIT. Consulta el archivo LICENSE para más información.
