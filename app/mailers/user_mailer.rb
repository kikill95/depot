class UserMailer < ApplicationMailer
  default from: 'noreply.depot@gmail.com'

  def signup_confirmation(user)
    @user = user

    mail to: @user.email, subject: 'Sign up confirmation'
  end
end
