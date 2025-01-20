class Product < ApplicationRecord
  has_many_attached :images

  # Validaciones
  validates :name, presence: true, uniqueness: { scope: :deleted_at }, length: { minimum: 3, maximum: 100 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :description, length: { maximum: 500 }
  validates :category, presence: true
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :inventory_entry_date, presence: true
  validates :images, presence: true, length: { minimum: 1, message: "Debe tener al menos una imagen" }
  validates :size, length: { maximum: 50 }, allow_blank: true
  validates :color, length: { maximum: 50 }, allow_blank: true


  before_create :set_inventory_entry_date

  def soft_delete
    update(deleted_at: Time.current)
  end

  private

  def set_inventory_entry_date
    self.inventory_entry_date ||= Time.current
  end
end
