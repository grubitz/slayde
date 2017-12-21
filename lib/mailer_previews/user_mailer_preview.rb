class UserMailerPreview < ActionMailer::Preview
  def confirmation_instructions
    user = User.new(email: 'taxation@is.theft', confirmation_token: 'dmowski')

    UserMailer.confirmation_instructions(user)
  end
  def reset_password_instructions
    user = User.new(email: 'taxation.is@theft', reset_password_token: 'michalkiewicz')

    UserMailer.reset_password_instructions(user)
  end
end