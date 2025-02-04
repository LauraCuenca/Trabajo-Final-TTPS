class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: [ :edit, :update, :create ]

  # GET /products
  def index
    @products = Product.where(deleted_at: nil)
    @products = apply_order(@products)
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

  def category
    @products = Product.where(deleted_at: nil)

    if params[:category].present?
      if params[:category] == "nuevos"
        @products = @products.order(created_at: :desc).limit(6)
      else
        category, subcategory = params[:category].split("-")
        @products = @products.where("category LIKE ?", "#{category}-#{subcategory}%")
      end
    end

    @products = apply_order(@products)
    @products = @products.page(params[:page]).per(9)

    respond_to do |format|
      format.html
      format.json { render json: @products }
      format.jpeg do
        render plain: "Formato no soportado", status: :not_acceptable
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

  def search
    @query = params[:query]
    if @query.present?
      @products = Product.where("LOWER(name) LIKE ? OR LOWER(description) LIKE ? OR LOWER(category) LIKE ?",
                                "%#{@query.downcase}%", "%#{@query.downcase}%", "%#{@query.downcase}%")
                        .where(deleted_at: nil)
    else
      @products = Product.where(deleted_at: nil)
    end

    @products = apply_order(@products)
    @products = @products.page(params[:page]).per(9)
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

  def apply_order(products)
    case params[:order]
    when "name_asc"
      products.order(:name)
    when "name_desc"
      products.order(name: :desc)
    when "price_asc"
      products.order(:price)
    when "price_desc"
      products.order(price: :desc)
    when "recent"
      products.order(inventory_entry_date: :desc)
    when "oldest"
      products.order(inventory_entry_date: :asc)
    else
      products.order(:name)
    end
  end
end
