class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit!)
    render :new unless @user.save
  end
end
