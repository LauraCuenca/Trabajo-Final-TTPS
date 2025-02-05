class Sale < ApplicationRecord
  belongs_to :employee, class_name: "User", foreign_key: "employee_id"
  has_many :sale_items
  has_many :products, through: :sale_items
  accepts_nested_attributes_for :sale_items

  # Validaciones
  validates :date, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
  validates :client_name, presence: true
  validates :status, inclusion: { in: %w[active canceled] }

  # Callbacks
  before_save :calculate_total_price
  before_update :restore_stock, if: :status_changed_to_canceled?
  before_create :set_default_status

  private

  def calculate_total_price
    self.total_price = sale_items.sum { |item| item.quantity * item.price }
  end

  def status_changed_to_canceled?
    status == "canceled" && status_was == "active"
  end

  def restore_stock
    sale_items.each do |item|
      product = item.product
      product.update(stock: product.stock + item.quantity)
    end
  end

  def set_default_status
    self.status ||= "active"
  end
end
