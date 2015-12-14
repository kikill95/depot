class OrdersController < ApplicationController
  def index
    @elements = session_products.map do |product|
      { product: Product.find(product['id']), quantity: product['quantity'] }
    end
  end

  def create
    return if session[:products].select { |el| el['id'] == params[:id] }.any?
    session[:products] << { id: params[:id], quantity: 1 }
  end

  def update
    updated_element(params[:id])['quantity'] = params[:quantity]
    render json: { message: 'Done', status: 200 }
  end

  def destroy
    @elements = session[:products].select! { |el| el['id'] != params[:id] }
  end

  private

  def updated_element(id)
    session[:products].find { |product| product['id'] == id }
  end
end
