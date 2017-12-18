class UserMailerPreview < ActionMailer::Preview
  def confirmation_instructions
    user = User.new(email: 'taxation@is.theft', confirmation_token: 'dmowski')

    UserMailer.confirmation_instructions(user)
  end
end