class OrdersController < ApplicationController
  def index
    @elements = session_products.map { |product|
      { product: Product.find(product['id']), currency: product['currency'] }
    }
  end

  def create
    return if session[:products].select{ |el| el['id'] == params[:id] }.any?
    session[:products] << { id: params[:id], currency: 1 }
  end

  def destroy
  end
end
