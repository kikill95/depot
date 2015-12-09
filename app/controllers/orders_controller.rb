class OrdersController < ApplicationController
  def index
    @elements = parser
    session[:total] ||= 0
  end

  def create
    return if session[:products].select { |el| el['id'] == params[:id] }.any?
    session[:products] << { id: params[:id], quantity: 1 }
  end

  def update
    updated_element(params[:id])['quantity'] = params[:quantity]
    session[:total] = calculate
    render json: { 'product': updated_element(params[:id]), 'total': session[:total] }
  end

  def destroy
    @elements = session[:products].select! { |el| el['id'] != params[:id] }
  end

  def total
    session[:total]
  end

  helper_method :total

  private

  def updated_element(id)
    session[:products].find { |product| product['id'] == id }
  end

  def parser
    session_products.map do |product|
      { product: Product.find(product['id']), quantity: product['quantity'] }
    end
  end

  def calculate
    sum = 0
    parser.each do |product|
      sum += product[:product].price * product[:quantity].to_i
    end
    sum
  end
end
