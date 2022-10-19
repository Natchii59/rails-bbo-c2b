class Api::ProductsController < ApplicationController
  load_and_authorize_resource

  # GET /products
  def index
    render json: Product.accessible_by(current_ability).all
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new product_params

    if @product.save
      render json: @product, status: :created
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update product_params
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy

    head :no_content
  end

  private

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :user_id)
  end
end
