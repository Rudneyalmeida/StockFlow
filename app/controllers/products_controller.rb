class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    accepted_offers_product_ids = Offer.accepted.pluck(:product_id)
  
    if params[:query].present?
      @products = Product.search_by_name_and_category(params[:query])
      @products = @products.where.not(id: accepted_offers_product_ids)
    else
      @products = Product.where.not(offered: true).where.not(id: accepted_offers_product_ids)
    end
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

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Product was successfully updated."
    else
      render :edit
    end
  end

  def my_products
    @products = current_user.products.where.not(offered: true)
  end

  def destroy
  end

  # def my_products
  #   @products = Product.where(user: current_user)
  # end

  private
  def product_params
    params.require(:product).permit(:name, :description, :category, :quantity, :expiration, :location, :photo)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
