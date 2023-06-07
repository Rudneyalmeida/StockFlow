class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.build(product_params)

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def my_products
    @products = current_user.products
  end

  def destroy
  end

  def my_products
    @products = Product.where(user: current_user)
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :category, :quantity, :expiration, :location, :photo)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
