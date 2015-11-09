class UsersController < ApplicationController
  require 'job_controller'

  def create
    @verifier = ActiveSupport::MessageVerifier.new('secret')
    if user.update(params.require(:user).permit!)
      @user.token = @verifier.generate([@user.id])
      Job.new.async.perform(@user.email, @user.token)
      @user.save
    else
      render(:new)
    end
  end

  def confirm
    
  end

  private

  def user
    @user ||= User.new
  end
  helper_method :user
end
