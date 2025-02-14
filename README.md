# Trabajo Practico Final Integrador
### ``` TTPS - Opcion Ruby```
Una tienda online de ropa con gestión de empleados.
Este proyecto fue desarrollado como parte del trabajo final integrador de la materia TTPS. Utiliza Ruby on Rails como framework principal.
![image](https://github.com/user-attachments/assets/5002c8cf-b20c-4b26-98c4-ee60021b5faf)


### ```Descripción del Proyecto```
Este proyecto es una tienda online de ropa que permite a los administradores gestionar productos y empleados, y a los clientes, navegar por los productos.

### ``` Funcionalidades principales:```
Gestión de productos:
 Crear, editar, listar y eliminar productos.<br>
Gestión de empleados:
 Registrar empleados y asignarles roles.<br>
Autenticación:
 Sistema de inicio de sesión para empleados,gerentes y administradores.<br>
Visualización de ventas:
 Los empleados pueden consultar ventas realizadas.

### ``` Características Principales```
Diseño responsive para garantizar una experiencia amigable en dispositivos móviles y de escritorio.
Sistema de roles para diferenciar entre usuarios y empleados.
Integración con Devise para manejo de autenticación.
Relación clara entre modelos (Productos, Ventas, Usuarios, Roles).

### ``` Tecnologías Utilizadas```
- Lenguaje Backend: Ruby (versión 3.2.0)
- Framework: Ruby on Rails (versión 7.x)
- Base de Datos: SQLite
- Front-End: HTML5, CSS3, Bootstrap
- Autenticación: Devise
- Otros:
    - Active Storage para la gestión de imágenes de productos.

### ``` Credenciales para iniciar sesion```
- administrador: 
   usuario: admin@gmail.com
   contraseña: password
- gerente:
  usuario: gerente@gmail.com
  contraseña: password
- empleado:
  usuario: uno@gmail.com
  contraseña: password

### ``` Requisitos Previos```
Antes de ejecutar el proyecto, asegúrate de tener instalados los siguientes componentes:

Ruby 3.2.0 o superior
Rails 7.x
Node.js y Yarn para gestionar paquetes front-end

### ``` Instalación y Ejecución```
Clona este repositorio en tu máquina local:
```bash
git clone https://github.com/LauraCuenca/Trabajo-Final-TTPS
cd tu_repositorio
```
Instala las dependencias:
```bash
bundle install
yarn install
```
Crea y migra la base de datos:
```bash
rails db:create
rails db:migrate
```
Carga los datos:
```bash
rails db:seed
```
Inicia el servidor:
```bash
rails server
Abre tu navegador y accede a http://localhost:3000.
```

