class UsersController < ApplicationController
  require 'MailerJob'

  def create
    @verifier = ActiveSupport::MessageVerifier.new('secret')
    if user.update(params.require(:user).permit!)
      @user.token = @verifier.generate([@user.id])
      MailerJob.new.async.perform(@user)
      @user.save
    else
      render(:new)
    end
  end

  def confirm
    @verifier = ActiveSupport::MessageVerifier.new('secret')
    user_id = @verifier.verify(params[:token])
    if user_id
      User.find(user_id).first.confirm!
    end
  end

  private

  def user
    @user ||= User.new
  end
  helper_method :user
end
