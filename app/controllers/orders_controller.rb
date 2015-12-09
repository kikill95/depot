class OrdersController < ApplicationController
  def index
    @elements = parser
    session[:total] ||= 0
  end

  def create
    return if session[:products].select{ |el| el['id'] == params[:id] }.any?
    session[:products] << { id: params[:id], quantity: 1 }
  end

  def update
    session[:products].find{ |product| product['id'] == params[:id]}['quantity'] = params[:quantity]
    session[:total] = calculate
    render json: session
  end

  def destroy
    @elements = session[:products].select!{ |el| el['id'] != params[:id] }
  end

  def total
    session[:total]
  end

  helper_method :total

  private

  def parser
    session_products.map { |product|
      { product: Product.find(product['id']), quantity: product['quantity'] }
    }
  end

  def calculate
    sum = 0
    parser.each do |product|
      sum += product[:product].price * product[:quantity].to_i
    end
    sum
  end
end
