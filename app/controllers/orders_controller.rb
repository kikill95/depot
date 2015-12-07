class OrdersController < ApplicationController
  def index
    @products = session_products.map { |product_id|
      Product.find(product_id)
    }
  end

  def create
    return if session[:products].include? params[:id]
    session[:products] << params[:id]
  end

  def destroy
  end
end
