class UserMailer < ApplicationMailer
  include Roadie::Rails::Automatic

  def confirmation_instructions(user)
    @user = user
    mail(to: user.email, subject: 'Confirmation instructions')
  end

  def reset_password_instructions(user)
    @user = user
    mail(to: user.email, subject: 'Resetting your password')
  end
end
