class Admin::ProductsController < ApplicationController
  before_action :require_user
  expose :product
  expose(:products) { |default| default.page(params[:page]).per(10) }

  def create
    if product.update(product_params)
      flash[:success] = 'Product was successfully created'
      redirect_via_turbolinks_to admin_product_path(product.id)
    else
      render :new
    end
  end

  def update
    current_product.update_attributes(product_params)
    flash[:success] = 'Product was successfully updated'
    redirect_via_turbolinks_to admin_products_path
  end

  def destroy
    current_product.destroy
    redirect_via_turbolinks_to admin_products_path
  end

  private

  def product_params
    params.require(:product).permit!
  end

  def product
    @product ||= Product.new
  end

  def current_product
    @current_product = Product.find(params[:id])
  end
  helper_method :product, :current_product
end
