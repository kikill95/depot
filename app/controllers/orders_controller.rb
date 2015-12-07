class OrdersController < ApplicationController
  def index
    @elements = session_products.map { |product|
      { product: Product.find(product['id']), currency: product['currency'] }
    }
  end

  def create
    return if session[:products].include? params[:id]
    session[:products] << { id: params[:id], currency: 1 }
  end

  def destroy
  end
end
