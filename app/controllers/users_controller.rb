class UsersController < ApplicationController
  def create
    render(:new) unless user.update(params.require(:user).permit!)
  end

  def confirm

  end

  private

  def user
    @user ||= User.new
  end
  helper_method :user
end
