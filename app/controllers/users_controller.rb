class UsersController < ApplicationController
  require 'job_controller'

  def create
    @verifier = ActiveSupport::MessageVerifier.new('secret')
    if user.update(params.require(:user).permit!)
      @user.token = @verifier.generate([@user.id])
      Job.new.async.perform(@user)
      @user.save
    else
      render(:new)
    end
  end

  def confirm(token)
    @verifier = ActiveSupport::MessageVerifier.new('secret')
    if verifier.verify(token)
      confirm!
    end  
  end

  private

  def confirm!
    @user.confirmed = true
  end

  def user
    @user ||= User.new
  end
  helper_method :user
end
