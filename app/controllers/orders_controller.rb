class OrdersController < ApplicationController
  def index
    @elements = session_products.map { |product|
      { product: Product.find(product['id']), quantity: product['quantity'] }
    }
  end

  def create
    return if session[:products].select{ |el| el['id'] == params[:id] }.any?
    session[:products] << { id: params[:id], quantity: 1 }
  end

  def destroy
    @elements = session[:products].select!{ |el| el['id'] != params[:id] }
  end
end
