class SalesController < ApplicationController
  before_action :set_sale, only: [ :cancel ]
  before_action :authenticate_user!, only: [ :create ]

  def index
    @sales = current_user.sales_as_employee.order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @sale = Sale.new
    @sale.sale_items.build
    @products = Product.all
  end

  def create
    @sale = Sale.new(sale_params)
    @sale.employee_id = current_user.id
    @sale.status = "active"
    @sale.date ||= Date.today
    @sale.total_price = @sale.sale_items.sum { |item| item.quantity * item.price }

    ActiveRecord::Base.transaction do
      if @sale.save
        params[:sale][:sale_items_attributes].each do |item_attributes|
          product = Product.find(item_attributes[:product_id])
          if product.stock >= item_attributes[:quantity].to_i
            sale_item = @sale.sale_items.build(product: product, quantity: item_attributes[:quantity], price: product.price)
            product.update!(stock: product.stock - sale_item.quantity)
          else
            raise ActiveRecord::Rollback, "No hay suficiente stock para el producto #{product.name}"
          end
        end

        respond_to do |format|
          format.html { redirect_to sales_path, notice: "Venta registrada exitosamente." }
          format.json { render json: @sale, status: :created }
        end
      else
        Rails.logger.debug "ERROR: #{@sale.errors.full_messages.inspect}"

        @products = Product.all
        respond_to do |format|
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @sale.errors, status: :unprocessable_entity }
        end
      end
    end
  rescue ActiveRecord::Rollback => e
    @sale.errors.add(:base, e.message)
    @products = Product.all
    respond_to do |format|
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @sale.errors, status: :unprocessable_entity }
    end
  end

  def cancel
    if @sale.status == "active"
      @sale.update(status: "canceled")
      redirect_to sales_path, notice: "Venta cancelada exitosamente y el stock ha sido actualizado."
    else
      redirect_to sales_path, alert: "La venta ya ha sido cancelada."
    end
  end

  private

  def set_sale
    @sale = Sale.find(params[:id])
  end

  def sale_params
    params.require(:sale).permit(:client_name, :date, :status, :employee_id, :total_price, sale_items_attributes: [ :product_id, :quantity, :price ])
  end
end
