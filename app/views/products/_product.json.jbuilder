json.extract! product, :id, :name, :description, :price, :stock, :category, :size, :color, :created_at, :updated_at
json.url product_url(product, format: :json)
