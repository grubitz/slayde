class ConfirmationMailer < ApplicationMailer

  def confirmation_instructions(user)
    @user = user
    mail(to: user.email, subject: 'Confirmation instructions')
  end
end
