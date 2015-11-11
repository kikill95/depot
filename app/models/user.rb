class User < ActiveRecord::Base
  has_secure_password

  validates :email, :password, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, uniqueness: true
  validates :password, length: { in: 6..20 }
  validates :password_confirmation, length: { in: 6..20 }

  def confirmation!
    UserMailer.welcome_email(self).deliver_now!
  end

  def confirm!
    self.confirmed = true
    save!(validate: false)
  end

end
