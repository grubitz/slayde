class User < ApplicationRecord
  validates :email, presence: true, format: { with: /.+@.+/ }, uniqueness: true
  validates :password, length: { minimum: 8 }
  has_secure_password

  def confirmed?
    confirmed_at.present?
  end

end

