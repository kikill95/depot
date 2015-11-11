class UserMailer < ApplicationMailer
	include Rails.application.routes.url_helpers

	default from: 'kirill.test.gus@gmail.com'

	def welcome_email(user)
		@user = user
		@url  = "#{root_url}user/confirm?token=#{@user.token}"
		mail(to: @user.email, subject: 'Confirmation of registration')
	end
end
