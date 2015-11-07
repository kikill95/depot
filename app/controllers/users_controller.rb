class UsersController < ApplicationController
  def create
    render(:new) unless user.update(params.require(:user).permit!)
  end

<<<<<<< HEAD
  def create
    @user = User.new(params.require(:user).permit!)
    render :new unless @user.save
=======
  private

  def user
    @user ||= User.new
>>>>>>> upstream/master
  end
  helper_method :user
end
