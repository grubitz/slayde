class User < ApplicationRecord
  validates :email, presence: true, format: { with: /.+@.+/ }, uniqueness: true
  validates :password, length: { minimum: 8 }, on: :create

  has_secure_password

  before_create :generate_token!
  after_create :send_confirmation_email!

  def confirmed?
    confirmed_at.present?
  end

  def confirm!
    update!(confirmed_at: Time.now, confirmation_token: nil)
  end

  def authenticate!(password)
    raise 'User not confirmed' unless confirmed?
    raise 'Invalid password' unless authenticate(password)
  end

  protected

  def generate_token!
    token = nil
    loop do
      token = SecureRandom.hex
      break unless User.where(confirmation_token: token).exists?
    end
    self.confirmation_token = token
  end

  def send_confirmation_email!
    ConfirmationMailer.confirmation_instructions(self).deliver_now
  end
end