class Api::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  def index
    render json: Product.all
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

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :user_id)
  end
end
