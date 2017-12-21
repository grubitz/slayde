class UserMailer < ApplicationMailer
  include Roadie::Rails::Automatic

  def confirmation_instructions(user)
    @user = user
    mail(to: user.email, subject: t('user_mailer.confirmation_instructions.subject'))
  end

  def reset_password_instructions(user)
    @user = user
    mail(to: user.email, subject: t('user_mailer.reset_password_instructions.subject'))
  end
end
