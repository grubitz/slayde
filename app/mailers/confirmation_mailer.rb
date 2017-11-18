class ConfirmationMailer < ApplicationMailer
include Roadie::Rails::Automatic
  def confirmation_instructions(user)
    @user = user
    mail(to: user.email, subject: 'Confirmation instructions')
  end
end
