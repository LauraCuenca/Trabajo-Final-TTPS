class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /products
  def index
    @products = Product.where(deleted_at: nil)
    case params[:order]
    when "name_asc"
      @products = @products.order(:name)
    when "name_desc"
      @products = @products.order(name: :desc)
    when "price_asc"
      @products = @products.order(:price)
    when "price_desc"
      @products = @products.order(price: :desc)
    when "recent"
      @products = @products.order(inventory_entry_date: :desc)
    when "oldest"
      @products = @products.order(inventory_entry_date: :asc)
    end
    @products = @products.page(params[:page]).per(9)
  end

  # GET /products/1
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    # set_product ya se ejecutó, @product está disponible
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "El producto se ha creado exitosamente" }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "El producto se actualizó." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  def destroy
    if @product.update(deleted_at: Time.current)
      redirect_to products_path, notice: "Producto eliminado correctamente."
    else
      Rails.logger.debug "Error al intentar eliminar el producto: #{@product.errors.full_messages}"
      redirect_to products_path, alert: "No se pudo eliminar el producto."
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Producto no encontrado."
    redirect_to products_path
  end

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :price,
      :stock,
      :category,
      :size,
      :color,
      :inventory_entry_date,
      images: []
    )
  end
end
