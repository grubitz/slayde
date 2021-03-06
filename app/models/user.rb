class User < ApplicationRecord
  validates :email, presence: true, format: { with: /.+@.+/ }, uniqueness: true
  validates :password, length: { minimum: 8 }, on: :create

  has_secure_password

  before_validation :normalize_email!
  before_create -> { generate_token!(:confirmation) }
  after_create :send_confirmation_email!, unless: :confirmed?

  def confirmed?
    confirmed_at.present?
  end

  def confirm!
    update!(confirmed_at: Time.now, confirmation_token: nil)
  end

  def send_reset_password!
    generate_token!(:reset_password)
    self.reset_password_sent_at = Time.now
    save!
    UserMailer.reset_password_instructions(self).deliver_now
  end

  def authenticate!(password)
    raise UserError.new(I18n.t('user.not_confirmed')) unless confirmed?
    raise UserError.new(I18n.t('invalid_password')) unless authenticate(password)
  end

  def update_with_password(params)
    unless authenticate(params.delete(:current_password))
      errors[:base] << I18n.t('invalid_password')
      return false
    end
    update(params)
  end

  protected

  def normalize_email!
    email.downcase! if email.present?
  end

  def generate_token!(token_type)
    token = nil
    loop do
      token = SecureRandom.hex
      break unless User.where("#{token_type}_token": token).exists?
    end
    self.send("#{token_type}_token=", token)
  end

  def send_confirmation_email!
    UserMailer.confirmation_instructions(self).deliver_now
  end
end
