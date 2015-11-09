class UsersController < ApplicationController
  include SuckerPunch::Job

  def create
    @verifier = ActiveSupport::MessageVerifier.new('secret')
    if user.update(params.require(:user).permit!)
      @user.token = @verifier.generate([@user.id])
      @user.save
    else
      render(:new)
    end
  end

  def confirm (token)

  end

  private

  def user
    @user ||= User.new
  end
  helper_method :user
end
