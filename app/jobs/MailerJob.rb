class MailerJob
  include SuckerPunch::Job

  def perform(user)
  	user.confirmation!
  end
end