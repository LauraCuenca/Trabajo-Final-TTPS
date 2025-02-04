class User < ApplicationRecord
  # Devise Modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validaciones
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true, format: { with: /\A\d+\z/, message: "solo debe contener números" }
  validates :password, presence: true, confirmation: true, on: :create
  validates :joined_on, presence: true
  validate :joined_on_not_in_the_future

  # Roles
  rolify

  normalize :username, with: [ :strip, :downcase ]
  normalize :email, with: [ :strip, :downcase ]

  def joined_on_not_in_the_future
    if joined_on.present? && joined_on > Date.today
      errors.add(:joined_on, "no puede ser una fecha futura")
    end
  end
end
