class WelcomeController < ApplicationController
  expose(:products) { |default| default.page(params[:page]).per(10) }

  def index
    @session = Session.new
    @items = Category.all
  end

  def current_product
    @current_product = Product.find(params[:id])
  end
  helper_method :current_product
end
