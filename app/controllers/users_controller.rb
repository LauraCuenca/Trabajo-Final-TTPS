class UsersController < ApplicationController
    def index
      @roles_with_users = Role.includes(:users).map do |role|
        puts "Rol: #{role.name}, Usuarios: #{role.users.pluck(:username)}"
        [ role.name, role.users ]
      end.to_h
    end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    role_id = params[:user][:role_ids].first
    role = Role.find_by(id: role_id)

    if role&.name == "administrador"
      flash[:alert] = "No se puede asignar el rol de administrador."
      render :new
      return
    end

    if @user.save
      @user.add_role(role.name) if role
      redirect_to users_path, notice: "Usuario registrado correctamente."
    else
      puts "Error al guardar el usuario: #{@user.errors.full_messages}"
      render :new
    end
  end


 private
 def user_params
  params.require(:user).permit(:username, :email, :phone, :password, :password_confirmation, :joined_on, role_ids: [])
 end
end
