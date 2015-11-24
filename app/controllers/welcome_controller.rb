class WelcomeController < ApplicationController

  def index
    @session = Session.new
	@items = Category.all
  	if params[:id]
  		@products = Category.find(params[:id]).products.page(params[:page]).per(10)
  	else
		@products = Product.page(params[:page]).per(10)
  	end
  end

  def current_product
    @current_product = Product.find(params[:id])
  end
  helper_method :current_product
end
