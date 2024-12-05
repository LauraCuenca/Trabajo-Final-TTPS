class User < ApplicationRecord
  # Devise Modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validaciones
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true, format: { with: /\A\d+\z/, message: "solo debe contener números" }
  validates :password, presence: true, confirmation: true
  validates :joined_on, presence: true
  validate :joined_on_not_in_the_future
  validate :role_is_not_admin, on: :create

  # Roles
  rolify

  before_save :downcase_fields

  def downcase_fields
    self.username = username.downcase if username.present?
    self.email = email.downcase if email.present?
    self.phone = phone.downcase if phone.present?
  end

  def joined_on_not_in_the_future
    if joined_on.present? && joined_on > Date.today
      errors.add(:joined_on, "no puede ser una fecha futura")
    end
  end

  def role_is_not_admin
    if roles.exists?(name: "administrador")
      errors.add(:roles, "No se puede asignar el rol de administrador.")
    end
  end
end
