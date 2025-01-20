class UsersController < ApplicationController
  before_action :set_user, except: [ :index, :new ]
  before_action :authenticate_user!
  before_action :verify_role_permission, only: [ :new, :create ]

    def show
      @user = current_user
    end

  def index
    @roles_with_users = Role.includes(:users).map do |role|
      [ role.name, role.users ]
    end.to_h
  end

  def new
    @user = User.new
    @roles = assignable_roles
  end

  def create
    @user = User.new(user_params)
    @user.active = true

    role_id = params[:user][:role_ids].first
    role = assignable_roles.find_by(id: role_id)

    if role.nil?
      flash.now[:alert] = "No tienes permiso para asignar este rol."
      @roles = assignable_roles
      render :new, status: :unprocessable_entity
      return
    end

    if @user.save
      @user.add_role(role.name)
      redirect_to users_path, notice: "Usuario registrado correctamente."
    else
      @roles = assignable_roles
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params_update)
      redirect_to user_path(@user), notice: "Tu perfil ha sido actualizado."
    else
      Rails.logger.debug "Errores de actualización: #{@user.errors.full_messages.inspect}"
      render :show, status: :unprocessable_entity
    end
  end

  def active?
    active
  end

  def deactivate
    if current_user.has_role?(:Administrador)
      if @user.update(active: false, password: generate_random_password)
        redirect_to users_path, notice: "La cuenta ha sido desactivada."
      else
        redirect_to users_path, alert: "Hubo un error al desactivar la cuenta."
      end
    else
      if current_user.update(active: false, password: generate_random_password)
        sign_out(current_user)
        redirect_to root_path, notice: "Tu cuenta ha sido desactivada."
      else
        redirect_to user_path(current_user), alert: "Hubo un error al desactivar tu cuenta."
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end


  def assignable_roles
    if current_user.has_role?(:Administrador)
      Role.all
    elsif current_user.has_role?(:Gerente)
      Role.where(name: [ "Gerente", "Empleado" ])
    else
      Role.none
    end
  end

  def verify_role_permission
    unless current_user.has_role?(:Administrador) || current_user.has_role?(:Gerente)
      redirect_to root_path, alert: "No tienes permiso para registrar usuarios."
    end
  end

  def authorize_admin
    unless current_user.has_role?(:Administrador)
      flash[:error] = "No tienes permiso para realizar esta acción."
      redirect_to root_path
    end
  end

  def generate_random_password
    SecureRandom.hex(8)
  end

  def user_params
    params.require(:user).permit(:username, :email, :phone, :password, :password_confirmation, :joined_on, role_ids: [])
  end

  def user_params_update
    params.require(:user).permit(:username, :email, :phone)
  end
end
